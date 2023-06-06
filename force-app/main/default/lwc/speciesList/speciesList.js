import { LightningElement, wire } from "lwc";
import { refreshApex } from "@salesforce/apex";
import getFilteredSpecies from "@salesforce/apex/SpeciesService.getFilteredSpecies";
import {
  registerRefreshHandler,
  unregisterRefreshHandler
} from "lightning/refresh";

export default class SpeciesList extends LightningElement {
  searchText = "";
  refreshHandlerID;

  connectedCallback() {
    this.refreshHandlerID = registerRefreshHandler(this, this.refreshHandler);
  }

  disconnectedCallback() {
    unregisterRefreshHandler(this.refreshHandlerID);
  }

  refreshHandler() {
    refreshApex(this.species);
  }

  @wire(getFilteredSpecies, { searchText: "$searchText" })
  species;

  handleInputChange(event) {
    const searchText = event.target.value;
    if (searchText.length >= 3 || searchText === "") {
      this.searchText = searchText;
    }
  }
}
