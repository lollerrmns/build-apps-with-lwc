import { LightningElement, track, api, wire } from "lwc";
import Shitter from "@salesforce/apex/Fase_nove.oportunidades";
import Pooper from "@salesforce/apex/Fase_nove.gravar";
import Asser from "@salesforce/apex/Fase_nove.oppss";

export default class Tst_Wire extends LightningElement {
  padrao = true;
  _selected = [];
  listOptions = [
    //{ value: "1", label: "Option 1" },
    //{ value: "2", label: "Option 2" },
  ];
  defaultOptions = [];
  requiredOptions = [];

  @api recordId;
  @wire(Shitter, { idd: "$recordId" })
  retorno({ error, data }) {
    if (error) {
      console.log("Error Data");
    } else if (data) {
      console.log("Success");
      //console.dir(data);
      data.forEach((element) => {
        //console.log('MUAMBA'+element.Name);
        this.listOptions.push({
          value: String(element.Id),
          label: String(element.Name),
        });
      });
      Asser({ idd: "Elias" })
        .then((result) => {
          console.dir(result);
          result.forEach((element) => {
            this.defaultOptions.push(String(element.Id));
          });
        })
        .catch((error) => {
          console.log(error);
        });
      //console.log('VAGABA');
      //console.dir(this.listOptions);
    }
  }

  get selected() {
    if (this._selected.length) {
      return this._selected;
    } else {
      return "NADA";
    }
  }

  handleChange(event) {
    this.padrao = false;
    this._selected = event.detail.value;
  }
  @track isModalOpen = false;
  openModal() {
    this.isModalOpen = true;

    this._selected = [];
    padrao = true;
  }
  closeModal() {
    this.isModalOpen = false;
  }
  submitDetails() {
    this.isModalOpen = false;

    Pooper({ idds: this._selected })
      .then((result) => {
        console.log("OK" + result);
        console.dir(result);
      })
      .catch((error) => {
        this.error = error;
      });
    if (this.padrao) {
      alert("PADRÃO " + this.defaultOptions);
    } else {
      alert("Selecionados " + this._selected);
    }
  }
}
