import { LightningElement, api } from "lwc";

export default class SpecieTile extends LightningElement {
  /*specie = {
    Name: "Jazmin",
    Description: "Olorosa y bonita planta trepadora",
    Image_URL__c:
      "https://i.pinimg.com/originals/88/a4/9f/88a49f73cb34bb49ea799087ad2fba15.jpg",
    Location__c: "Indoors,Outdoors"
  };*/
  @api specie;
}
