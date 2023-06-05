import { LightningElement, api } from "lwc";

export default class DisplayImg extends LightningElement {
  @api url;
  @api width;
  @api height;
  @api output;
}
