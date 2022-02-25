import { createElement } from "lwc";
import SpecieTile from "c/specieTile";

describe("c-specie-tile", () => {
  afterEach(() => {
    // The jsdom instance is shared across test cases in a single file so reset the DOM
    while (document.body.firstChild) {
      document.body.removeChild(document.body.firstChild);
    }
  });

  // Helper function to wait until the microtask queue is empty. This is needed for promise
  // timing when calling imperative Apex.
  async function flushPromises() {
    return Promise.resolve();
  }

  it("DOM renderiza correctamente cosas que dependen de la inicialización", () => {
    // GIVEN
    const element = createElement("c-specie-tile", {
      is: SpecieTile
    });
    element.specie = {
      Name: "Jazmin",
      Description: "Olorosa y bonita planta trepadora",
      Image_URL__c:
        "https://i.pinimg.com/originals/88/a4/9f/88a49f73cb34bb49ea799087ad2fba15.jpg",
      Location__c: "Indoors,Outdoors"
    };

    // WHEN
    document.body.appendChild(element);

    // THEN
    // Query lightning-card element
    const lightningCardEl = element.shadowRoot.querySelector("lightning-card");
    expect(lightningCardEl).not.toBeNull();
    expect(lightningCardEl.title).toBe("Jazmin");
  });

  it("Icono indoors se muestra si location incluye indoors", () => {
    // Create initial element
    /*const element = createElement('c-chart-bar', {
            is: ChartBar
        });
        document.body.appendChild(element);

        // Query lightning-layout element
        const lightningLayoutEl =
            element.shadowRoot.querySelector('lightning-layout');
        expect(lightningLayoutEl).not.toBeNull();

        // Query lightning-layout-item elements
        const lightningLayoutItemEls = element.shadowRoot.querySelectorAll(
            'lightning-layout-item'
        );
        expect(lightningLayoutItemEls.length).toBe(2);*/
  });

  it("Icono indoors no se muestra si location no incluye indoors", () => {});

  it("Cuando se clicka lightning-button se llama al servicio de navegación", () => {});
});
