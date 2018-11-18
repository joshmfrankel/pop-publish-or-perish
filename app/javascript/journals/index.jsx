import React from "react";
import ReactDOM from "react-dom";
import Modal from "../shared/Modal";

// Component Constants
const JOURNAL_HEADERS = ["Title", "Impact Factor", ""];

class JournalListing extends React.Component {
  constructor(props) {
    super(props);

    this.state = {
      journals: this.props.journals,
      sortDirection: 1,
      showModal: false,
      editing: null
    };

    this.setSortDirection = this.setSortDirection.bind(this);
    this.handleSearch = this.handleSearch.bind(this);
    this.handleCloseModal = this.handleCloseModal.bind(this);
    this.handleSubmitModal = this.handleSubmitModal.bind(this);
    this.displayBlankState = this.displayBlankState.bind(this);
  }

  /**
   * Binary flips an integer to be used for journal sorting method
   */
  setSortDirection() {
    const sortDirection = this.state.sortDirection;
    this.setState({ sortDirection: sortDirection * -1 })
    return {
      up: sortDirection * -1,
      down: sortDirection,
    }
  }

  /**
   * Sorts a listing of journals in a table
   * @param  {str} attribute - The named attribute to sort
   * @return {void}            Updates the journals state
   */
  sortJournals(attribute) {
    const currentSortDirection = this.setSortDirection();

    this.setState({
      journals:
      this.state.journals.sort((currentJournal, nextJournal) => {
        if (currentJournal[attribute] < nextJournal[attribute]) {
          return currentSortDirection['up'];
        } else if (currentJournal[attribute] > nextJournal[attribute]) {
          return currentSortDirection['down'];
        }
        return 0;
      })
    });
  }

  handleSearch(event) {
    let searchTerm = event.target.value;
    let matches = this.props.journals;

    if (searchTerm.length >= 3) {
      matches = this.state.journals.filter(j => j["title"].includes(searchTerm));
    }

    this.setState({ journals: matches });
  }

  displayBlankState() {
    if(this.state.journals.length === 0) {
      return (
        <tr>
          <td colSpan="3" className="tac">There are no available Journals</td>
        </tr>
      );
    }
  }

  onJournalEdit(journal) {
    this.setState({ showModal: true, editing: journal });
  }

  onJournalDelete(journalId) {
    let journals = this.state.journals.filter(i => i["id"] !== journalId);

    if(confirm("Are you sure you want to delete this Journal?")) {
      fetch('journals/' + journalId, {
        method: "DELETE",
        headers: {
          'X-CSRF-Token': this.props.token
        },
        credentials: 'same-origin'
      }).then(function() {
        this.setState({ journals: journals});
      });
    }
  }

  handleCloseModal() {
    this.setState({ showModal: false, editing: null });
  }

  handleSubmitModal() {

    this.handleCloseModal(); // Ensure we reset the modal state
  }

  render() {
    const journals = this.state.journals;
    const token = this.props.token;

    return(
      <div className="Journal-listing">
        <input
          name="search"
          placeholder="Search"
          onChange={this.handleSearch} /><br />
        <table>
          <thead>
            <tr>
              <th onClick={() => this.sortJournals("title")}>Title</th>
              <th onClick={() => this.sortJournals("impact_factor")}>Impact Factor</th>
              <th></th>
              <th></th>
            </tr>
          </thead>
          <tbody>
            {this.displayBlankState()}

            {journals.map((journal) =>
              <tr key={journal.id}>
                <td>{journal.title}</td>
                <td>{journal.impact_factor}</td>
                <td onClick={this.onJournalEdit.bind(this, journal)}><button>Edit</button></td>
                <td onClick={this.onJournalDelete.bind(this, journal.id)}><button>Delete</button></td>
              </tr>
            )}
          </tbody>
        </table>
        {this.state.showModal &&
          <Modal
            onCloseModal={this.handleCloseModal}
            onSubmitModal={this.handleSubmitModal}
            title="Edit Journal"
            currentRecord={this.state.editing}
          />
        }
      </div>
    );
  }
}

// See: https://coderwall.com/p/z4cd4g/integrate-with-turbolinks-and-webpacker-react
// For more information about why we use the following event
// instead of DOMContentLoaded
document.addEventListener('turbolinks:load', () => {
  const node = document.getElementById("journals_listing")
  const data = JSON.parse(node.getAttribute("data"))

  ReactDOM.render(
    <JournalListing journals={data.journals} token={data.token} />,
    document.querySelector(".Content-target"),
  )
})

