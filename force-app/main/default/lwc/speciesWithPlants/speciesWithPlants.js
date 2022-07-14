import { LightningElement, wire } from "lwc";
import getSpeciesWithPlants from "@salesforce/apex/SpeciesService.getSpeciesWithPlants";

export default class SpeciesWithPlants extends LightningElement {
  @wire(getSpeciesWithPlants)
  species;
}
