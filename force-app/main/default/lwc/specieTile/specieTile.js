import { LightningElement, api } from "lwc";
import { NavigationMixin } from "lightning/navigation";

export default class SpecieTile extends NavigationMixin(LightningElement) {
  /*specie = {
    Name: "Jazmin",
    Description: "Olorosa y bonita planta trepadora",
    Image_URL__c:
      "https://i.pinimg.com/originals/88/a4/9f/88a49f73cb34bb49ea799087ad2fba15.jpg",
    Location__c: "Indoors,Outdoors"
  };*/
  @api specie;

  get showIndoorsIcon() {
    return this.specie.Location__c?.includes("Indoors");
  }

  get showOutdoorsIcon() {
    return this.specie.Location__c?.includes("Outdoors");
  }

  handleViewDetails() {
    this[NavigationMixin.Navigate]({
      type: "standard__recordPage",
      attributes: {
        recordId: this.specie.Id,
        actionName: "view"
      }
    });
  }
}
