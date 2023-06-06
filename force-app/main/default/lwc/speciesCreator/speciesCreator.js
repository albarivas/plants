import { LightningElement } from "lwc";
import { ShowToastEvent } from "lightning/platformShowToastEvent";
import { RefreshEvent } from "lightning/refresh";
import SPECIES_OBJECT from "@salesforce/schema/Species__c";
import NAME_FIELD from "@salesforce/schema/Species__c.Name";
import IMAGE_NAME_FIELD from "@salesforce/schema/Species__c.Image_Name__c";
import DESCRIPTION_FIELD from "@salesforce/schema/Species__c.Description__c";
import LOCATION_FIELD from "@salesforce/schema/Species__c.Location__c";

export default class SpeciesCreator extends LightningElement {
  nameField = NAME_FIELD;
  imageNameField = IMAGE_NAME_FIELD;
  descriptionField = DESCRIPTION_FIELD;
  locationField = LOCATION_FIELD;

  objectApiName = SPECIES_OBJECT;

  handleSuccess() {
    const event = new ShowToastEvent({
      title: "Success",
      message: "Record created successfully",
      variant: "success"
    });
    this.dispatchEvent(event);

    // Refresh subscribed components
    this.dispatchEvent(new RefreshEvent());

    // Reset fields
    const inputFields = this.template.querySelectorAll("lightning-input-field");
    inputFields?.forEach((field) => field.reset());
  }

  handleError() {
    const event = new ShowToastEvent({
      title: "Error",
      message: "Error creating record",
      variant: "error"
    });
    this.dispatchEvent(event);
  }
}
