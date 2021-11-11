import { LightningElement } from "lwc";

export default class SpeciesList extends LightningElement {
  species = [
    {
      Name: "Jazmin",
      Description: "Olorosa y bonita planta trepadora",
      Image_URL__c:
        "https://i.pinimg.com/originals/88/a4/9f/88a49f73cb34bb49ea799087ad2fba15.jpg",
      Location__c: "Indoors,Outdoors"
    },
    {
      Name: "Aloe Vera",
      Description:
        "Conocida por sus propiedades medicinales y aplicaciones para la piel",
      Image_URL__c:
        "https://www.farmaceuticonline.com/wp-content/uploads/2019/03/aloevera-1024x768.jpg",
      Location__c: "Outdoors"
    },
    {
      Name: "Hierbabuena",
      Description:
        "Arómatica que huele de maravilla, muy usada en la gastronomía, en la medicina popular y para hacer te",
      Image_URL__c:
        "https://decoracionyjardines.com/wp-content/uploads/2017/02/cuidados-de-la-hierbabuena.jpg",
      Location__c: "Outdoors"
    }
  ];
}
