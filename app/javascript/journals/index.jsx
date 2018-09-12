import React from "react"
import ReactDOM from "react-dom"
import Row from "./Row"

// Component Constants
const JOURNAL_HEADERS = ["Title", "Description", "Impact Factor", ""];

class JournalListing extends React.Component {
  constructor(props) {
    super(props);

    this.state = {
      journals: this.props.journals,
      sortDirection: 1,
    };

    this.setSortDirection = this.setSortDirection.bind(this);
    this.handleSearch = this.handleSearch.bind(this);
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

  // @Todo: Only change state if fetch success
  removeJournal(journalId) {
    let journals = this.state.journals.filter(i => i["id"] !== journalId);

    if(confirm("Are you sure you want to delete this Journal?")) {
      this.setState({ journals: journals});
      fetch('journals/' + journalId, {
        method: "DELETE",
        headers: {
          'X-CSRF-Token': this.props.token
        },
        credentials: 'same-origin'
      });
    }
  }

  handleSearch(event) {
    let searchTerm = event.target.value;
    let matches = this.props.journals;

    if (searchTerm.length >= 3) {
      matches = this.state.journals.filter(j => j["title"].includes(searchTerm));
    }

    this.setState({ journals: matches });
  }

  render() {
    const journals = this.state.journals;
    const token = this.props.token;

    return(
      <div>
        <input
          name="search"
          placeholder="Search"
          onChange={this.handleSearch} /><br />
        <table>
          <thead>
            <tr>
              <th onClick={() => this.sortJournals("title")}>Title</th>
              <th onClick={() => this.sortJournals("description")}>Description</th>
              <th onClick={() => this.sortJournals("impact_factor")}>Impact Factor</th>
              <th></th>
              <th></th>
            </tr>
          </thead>
          <tbody>
            {journals.length == 0 &&
              <tr><td colSpan="4" className="tac">There are no available Journals</td></tr>
            }
            {journals.map((journal) =>
              <Row
                journal={journal}
                key={journal.id}
                token={token}
                handleRemoveJournal={this.removeJournal.bind(this, journal.id)}
              />
            )}
          </tbody>
        </table>
      </div>
    );
  }
}

// DOMContentLoaded
document.addEventListener('turbolinks:load', () => {
  const journalsNode = document.getElementById("journals_listing")
  const journalsListingData = JSON.parse(journalsNode.getAttribute("data"))

  ReactDOM.render(
    <JournalListing journals={journalsListingData.journals} token={journalsListingData.token} />,
    document.querySelector(".Content-target").appendChild(document.createElement('div')),
  )
})

