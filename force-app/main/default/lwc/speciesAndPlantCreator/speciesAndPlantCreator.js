import { LightningElement } from "lwc";
import { ShowToastEvent } from "lightning/platformShowToastEvent";
import createSpeciesWithPlant from "@salesforce/apex/SpeciesService.createSpeciesWithPlant";

export default class SpeciesAndPlantCreator extends LightningElement {
  speciesName;
  plantAcquisitionDate;

  handleSpeciesNameChange(event) {
    this.speciesName = event.target.value;
  }

  handleAcquisitionDateChange(event) {
    this.plantAcquisitionDate = event.target.value;
  }

  handleButtonClick() {
    createSpeciesWithPlant({
      speciesName: this.speciesName,
      plantAcquisitionDate: this.plantAcquisitionDate
    })
      .then(() => {
        const evt = new ShowToastEvent({
          title: "Success",
          message: "Species & Plant created correctly",
          variant: "success"
        });
        this.dispatchEvent(evt);
      })
      .catch((error) => {
        const evt = new ShowToastEvent({
          title: "Error",
          message: "Error creating records: " + error,
          variant: "error"
        });
        this.dispatchEvent(evt);
      });
  }
}
