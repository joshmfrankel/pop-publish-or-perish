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

  render() {
    const journals = this.state.journals;

    return(
      <div>
        <table>
          <thead>
            <tr>
              <th onClick={() => this.sortJournals("title")}>Title</th>
              <th onClick={() => this.sortJournals("description")}>Description</th>
              <th onClick={() => this.sortJournals("impact_factor")}>Impact Factor</th>
              <th></th>
            </tr>
          </thead>
          <tbody>
            {journals.map((journal) =>
              <Row
                journal={journal}
                key={journal.id}
              />
            )}
          </tbody>
        </table>
      </div>
    );
  }
}

document.addEventListener('DOMContentLoaded', () => {
  const journalsNode = document.getElementById("journals_listing")
  const journalsListingData = JSON.parse(journalsNode.getAttribute("data"))

  ReactDOM.render(
    <JournalListing journals={journalsListingData} />,
    document.body.appendChild(document.createElement('div')),
  )
})

