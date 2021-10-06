// Visit The Stimulus Handbook for more details
// https://stimulusjs.org/handbook/introduction
//
// This example controller works with specially annotated HTML like:
//
// <div data-controller="hello">
//   <h1 data-target="hello.output"></h1>
// </div>

import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "term" ]

  get term() {
    return this.termTarget.value;
  }

  addQueryString() {
    console.log('You clicked me');
    if (this.term === "") {
      const cleanURL = location.protocol + "//" + location.host + location.pathname;
      history.replaceState({}, document.title, cleanURL);
    } else {
      history.replaceState(null, null, `?search_term=${this.term}`);
    }
  }
}
