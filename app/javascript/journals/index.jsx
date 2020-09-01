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
    this.handleModalSubmit = this.handleModalSubmit.bind(this);
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
    // Determine proper state by removing journal from listing
    let journals = this.state.journals.filter(i => i["id"] !== journalId);

    if(confirm("Are you sure you want to delete this Journal?")) {
      fetch('journals/' + journalId, {
        method: "DELETE",
        headers: {
          'X-CSRF-Token': this.props.token
        },
        credentials: 'same-origin'
      }).then(() => {
        // Only update journal listing after successful removal
        this.setState({ journals: journals });
      });
    }
  }

  handleCloseModal() {
    this.setState({ showModal: false, editing: null });
  }

  /**
   * Map through child component's updated journal details and merge updated
   * journal data onto array index object that matches
   */
  handleModalSubmit(updatedJournalData) {
    const journals = this.state.journals.map(journal =>
      journal.id === updatedJournalData.id ? { ...journal, ...updatedJournalData } : journal
    );
    this.setState({ journals });
  }

  render() {
    const { journals } = this.state;

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
                {this.props.user.is_admin && (
                  <React.Fragment>
                    <td onClick={this.onJournalEdit.bind(this, journal)}>
                      <button title="Edit">
                        <i className="fas fa-pencil-alt"></i>
                      </button>
                    </td>
                    <td onClick={this.onJournalDelete.bind(this, journal.id)}>
                      <button title="Delete">
                        <i className="fas fa-trash-alt"></i>
                      </button>
                    </td>
                   </React.Fragment>
                 )}
                {!!this.props.user.is_admin && (
                  <React.Fragment>
                    <td></td>
                    <td></td>
                  </React.Fragment>
                )}
              </tr>
            )}
          </tbody>
        </table>
        {this.state.showModal &&
          <Modal
            onCloseModal={this.handleCloseModal}
            onSubmit={this.handleModalSubmit}
            modalTitle="Edit Journal"
            currentRecord={this.state.editing}
            token={this.props.token}
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
    <JournalListing journals={data.journals} token={data.token} user={data.user} />,
    document.querySelector(".Content-target"),
  )
})

