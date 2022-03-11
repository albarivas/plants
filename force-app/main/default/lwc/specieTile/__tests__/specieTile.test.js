import { getNavigateCalledWith } from "lightning/navigation";
import { createElement } from "lwc";
import SpecieTile from "c/specieTile";

describe("c-specie-tile", () => {
  afterEach(() => {
    // The jsdom instance is shared across test cases in a single file so reset the DOM
    while (document.body.firstChild) {
      document.body.removeChild(document.body.firstChild);
    }
  });

  // Helper function to wait until the microtask queue is empty. This is needed for promise
  // timing when calling imperative Apex.
  async function flushPromises() {
    return Promise.resolve();
  }

  it("DOM renderiza correctamente cosas que dependen de la inicialización", () => {
    // GIVEN
    const element = createElement("c-specie-tile", {
      is: SpecieTile
    });

    element.specie = {
      Name: "Jazmin",
      Description: "Olorosa y bonita planta trepadora",
      Image_URL__c:
        "https://i.pinimg.com/originals/88/a4/9f/88a49f73cb34bb49ea799087ad2fba15.jpg",
      Location__c: "Indoors,Outdoors"
    };

    // WHEN
    document.body.appendChild(element);

    // THEN
    // Query lightning-card element
    const lightningCardEl = element.shadowRoot.querySelector("lightning-card");
    expect(lightningCardEl).not.toBeNull();
    expect(lightningCardEl.title).toBe("Jazmin");
    // Query img element
    const imgEl = element.shadowRoot.querySelector("img");
    expect(imgEl).not.toBeNull();
    expect(imgEl.src).toBe(
      "https://i.pinimg.com/originals/88/a4/9f/88a49f73cb34bb49ea799087ad2fba15.jpg"
    );
  });

  it("Icono indoors se muestra si location incluye indoors", () => {
    // GIVEN
    const element = createElement("c-specie-tile", {
      is: SpecieTile
    });
    element.specie = {
      Name: "Jazmin",
      Description: "Olorosa y bonita planta trepadora",
      Image_URL__c:
        "https://i.pinimg.com/originals/88/a4/9f/88a49f73cb34bb49ea799087ad2fba15.jpg",
      Location__c: "Indoors"
    };

    // WHEN
    document.body.appendChild(element);

    // THEN
    // Query lightning-card element
    const lightningIconEl = element.shadowRoot.querySelector("lightning-icon");
    expect(lightningIconEl).not.toBeNull();
    expect(lightningIconEl.iconName).toBe("standard:home");
  });

  it("Icono indoors no se muestra si location no incluye indoors", () => {
    // GIVEN
    const element = createElement("c-specie-tile", {
      is: SpecieTile
    });
    element.specie = {
      Name: "Jazmin",
      Description: "Olorosa y bonita planta trepadora",
      Image_URL__c:
        "https://i.pinimg.com/originals/88/a4/9f/88a49f73cb34bb49ea799087ad2fba15.jpg",
      Location__c: ""
    };

    // WHEN
    document.body.appendChild(element);

    // THEN
    // Query lightning-card element
    const lightningIconEl = element.shadowRoot.querySelector("lightning-icon");
    expect(lightningIconEl).toBeNull();
  });

  it("Los dos iconos se muestran si location incluye indoors y outdoors", () => {
    // GIVEN
    const element = createElement("c-specie-tile", {
      is: SpecieTile
    });
    element.specie = {
      Name: "Jazmin",
      Description: "Olorosa y bonita planta trepadora",
      Image_URL__c:
        "https://i.pinimg.com/originals/88/a4/9f/88a49f73cb34bb49ea799087ad2fba15.jpg",
      Location__c: "Indoors,Outdoors"
    };

    // WHEN
    document.body.appendChild(element);

    // THEN
    // Query lightning-card elements
    const lightningIconEls =
      element.shadowRoot.querySelectorAll("lightning-icon");
    expect(lightningIconEls.length).toBe(2);
    expect(lightningIconEls[0].iconName).toBe("custom:custom3");
    expect(lightningIconEls[1].iconName).toBe("standard:home");
  });

  it("Cuando se clicka lightning-button se llama al servicio de navegación", () => {
    // GIVEN - inicializo el componente
    const element = createElement("c-specie-tile", {
      is: SpecieTile
    });
    element.specie = {
      Id: "12345678",
      Name: "Jazmin",
      Description: "Olorosa y bonita planta trepadora",
      Image_URL__c:
        "https://i.pinimg.com/originals/88/a4/9f/88a49f73cb34bb49ea799087ad2fba15.jpg",
      Location__c: "Indoors,Outdoors"
    };

    document.body.appendChild(element);

    // WHEN - clicka el lightning-button
    const lightningButtonEl =
      element.shadowRoot.querySelector("lightning-button");
    lightningButtonEl.click();

    // THEN - se ha llamado al servicio de navegación con la pag esperada
    const { pageReference } = getNavigateCalledWith();

    // Verify component called with correct event type and params
    /* {
      type: "standard__recordPage",
      attributes: {
        recordId: this.specie.Id,
        actionName: "view"
      }*/
    expect(pageReference.type).toBe("standard__recordPage");
    expect(pageReference.attributes.actionName).toBe("view");
    expect(pageReference.attributes.recordId).toBe("12345678");
  });
});
