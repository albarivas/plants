import { api, LightningElement } from "lwc";

export default class SpeciesTileBodyContent extends LightningElement {
  @api description;
  @api imageURL;
  @api name;
  @api showOutdoorsIcon;
  @api showIndoorsIcon;
}
