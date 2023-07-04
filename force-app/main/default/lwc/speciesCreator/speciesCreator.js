import { LightningElement } from "lwc";
import SPECIES_OBJECT from "@salesforce/schema/Species__c";
import NAME_FIELD from "@salesforce/schema/Species__c.Name";
import DESCRIPTION_FIELD from "@salesforce/schema/Species__c.Description__c";
import LOCATION_FIELD from "@salesforce/schema/Species__c.Location__c";
import { ShowToastEvent } from "lightning/platformShowToastEvent";
import { RefreshEvent } from "lightning/refresh";

export default class SpeciesCreator extends LightningElement {
  objectApiName = SPECIES_OBJECT;
  nameField = NAME_FIELD;
  descriptionField = DESCRIPTION_FIELD;
  locationField = LOCATION_FIELD;

  handleSuccess() {
    // MOstramos el toast
    const event = new ShowToastEvent({
      title: "Success",
      message: "Record created successfully",
      variant: "success"
    });
    this.dispatchEvent(event);

    // Lanzamos el evento de Refresh
    this.dispatchEvent(new RefreshEvent());
  }

  handleError() {
    const event = new ShowToastEvent({
      title: "Success",
      message: "Error creating record",
      variant: "error"
    });
    this.dispatchEvent(event);
  }
}
