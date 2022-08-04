import { LightningElement, wire } from "lwc";
import getSpeciesWithPlants from "@salesforce/apex/SpeciesService.getSpeciesWithPlants";

export default class SpeciesWithPlants extends LightningElement {
  // Inicialización --> llamar al metodo de Apex que trae las especies con sus plantas
  @wire(getSpeciesWithPlants)
  speciesWithPlants;
}
