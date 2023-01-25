import { LightningElement, api } from "lwc";

export default class DisplayImg extends LightningElement {
  @api url;
  @api width;
  @api height;
  output;

  connectedCallback() {
    this.output = 100;
  }
}
