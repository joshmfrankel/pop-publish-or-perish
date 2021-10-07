
import { Controller } from "stimulus"

export default class extends Controller {

  // We use requestSubmit as .submit() doesn't work with turbo frames and stimulus
  // @see https://www.viget.com/articles/five-turbo-lessons-i-learned-the-hard-way/
  submit() {
    this.element.requestSubmit();
  }
}
