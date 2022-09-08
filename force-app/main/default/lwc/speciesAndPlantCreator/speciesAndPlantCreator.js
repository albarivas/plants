import { LightningElement, api } from "lwc";
import { ShowToastEvent } from "lightning/platformShowToastEvent";
import { CloseActionScreenEvent } from "lightning/actions";
import createSpeciesWithPlant from "@salesforce/apex/SpeciesService.createSpeciesWithPlant";

export default class SpeciesAndPlantCreator extends LightningElement {
  speciesName;
  plantAcquisitionDate;
  @api recordId;

  handleSpeciesNameChange(event) {
    this.speciesName = event.target.value;
  }

  handleAcquisitionDateChange(event) {
    this.plantAcquisitionDate = event.target.value;
  }

  handleCancelButtonClick() {
    // Add your cancel button implementation here
    this.dispatchEvent(new CloseActionScreenEvent());
  }

  handleCreateButtonClick() {
    console.log(
      "Registro desde el que se lanzó la quick action: " + this.recordId
    );
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
