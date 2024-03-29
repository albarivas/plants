import { wire, LightningElement } from "lwc";
import getAssociationsInfo from "@salesforce/apex/AssociationsController.getAssociationsInfo";
import { gql, graphql } from "lightning/uiGraphQLApi";

const RED = "rgb(239, 182, 182)";
const GREEN = "rgb(176, 255, 166)";

export default class AssociationsChecker extends LightningElement {
  edibleSpecies;
  edibleSpeciesIds;
  errors;

  @wire(graphql, {
    query: gql`
      query SpeciesList {
        uiapi {
          query {
            Species__c(first: 200, where: { Type__c: { eq: "Edible" } }) {
              edges {
                node {
                  Id
                  Name {
                    value
                  }
                }
              }
            }
          }
        }
      }
    `
  })
  getExistingSpecies({ data, errors }) {
    if (data) {
      this.edibleSpecies = data.uiapi.query.Species__c.edges.map((edge) => ({
        Id: edge.node.Id,
        Name: edge.node.Name.value
      }));
      // Get speciesIds so their associations are retrieved
      this.edibleSpeciesIds = this.edibleSpecies.map((species) => species.Id);
      this.errors = undefined;
    } else if (errors) {
      this.errors = errors;
      this.edibleSpecies = undefined;
    }
  }

  @wire(getAssociationsInfo, { speciesIds: "$edibleSpeciesIds" })
  associationsInfo;

  onDragStart(event) {
    event.dataTransfer.setData("text/plain", event.target.dataset.id);
  }

  onDragOver(event) {
    event.preventDefault();
  }

  onDrop(event) {
    const dataIdProp = event.dataTransfer.getData("text");

    let draggableElement = this.template.querySelector(
      `[data-id=${dataIdProp}]`
    );

    // If dragging from species area, clone element
    const fromSpeciesArea = !draggableElement.dataset.id.includes("_");
    if (fromSpeciesArea) {
      // Get number of clones, to determine next index
      const clonedElements = this.template.querySelectorAll(
        `[data-id^=${dataIdProp}]`
      );
      const clonedElement = draggableElement.cloneNode(true);
      clonedElement.addEventListener("dragstart", this.onDragStart);
      clonedElement.dataset.id = `${clonedElement.dataset.id}_${clonedElements.length}`;
      clonedElement.classList.add("dropped");
      const removeElementLink = clonedElement.querySelector("a.remove-element");
      removeElementLink.classList.toggle("slds-hide");
      removeElementLink.addEventListener("click", this.removeElement);
      draggableElement = clonedElement;
    }

    const dropzone = event.target;
    dropzone.appendChild(draggableElement);

    event.dataTransfer.clearData();
  }

  checkAssociations() {
    const droppedElements = this.template.querySelectorAll(
      ".species-element.dropped"
    );
    droppedElements.forEach((droppedElement) => {
      // Find species associations info
      if (this.associationsInfo.data) {
        const droppedElementId = droppedElement.dataset.id.includes("_")
          ? droppedElement.dataset.id.split("_")[0]
          : droppedElement.dataset.id;
        // Find next sibling in same column
        const nextSibling = droppedElement.nextSibling;
        const speciesWithAssociationsInfo = this.associationsInfo.data.find(
          (species) => species.speciesId === droppedElementId
        );
        if (nextSibling != null) {
          this.changeBackgroundColor(
            droppedElement,
            nextSibling,
            speciesWithAssociationsInfo
          );
        }
        // Find sibling in next column
        const nextColumn = droppedElement.parentElement.nextSibling;
        const indexInOwnColumn = [
          ...droppedElement.parentNode.children
        ].indexOf(droppedElement);
        const siblingInNextColumn = nextColumn.children[indexInOwnColumn];
        if (siblingInNextColumn != null) {
          this.changeBackgroundColor(
            droppedElement,
            siblingInNextColumn,
            speciesWithAssociationsInfo
          );
        }
      }
    });
  }

  changeBackgroundColor(droppedElement, sibling, speciesWithAssociationsInfo) {
    const siblingId = sibling.dataset.id.includes("_")
      ? sibling.dataset.id.split("_")[0]
      : sibling.dataset.id;

    if (speciesWithAssociationsInfo.goodPartners.includes(siblingId)) {
      sibling.style.backgroundColor = GREEN;
      if (droppedElement.style.backgroundColor !== RED) {
        droppedElement.style.backgroundColor = GREEN;
      }
    } else if (speciesWithAssociationsInfo.badPartners.includes(siblingId)) {
      sibling.style.backgroundColor = RED;
      droppedElement.style.backgroundColor = RED;
    }
  }

  removeElement(event) {
    event.currentTarget.parentElement.remove();
  }
}
