import React from "react"
import ReactDOM from "react-dom"
import Row from "./Row"

class JournalListing extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      journals: this.props.journals,
    }
  }
  sortJournals(attribute) {
    this.setState({
      journals:
      this.state.journals.sort((currentJournal, nextJournal) => {
        if (currentJournal[attribute] < nextJournal[attribute]) {
          return -1;
        } else if (currentJournal[attribute] > nextJournal[attribute]) {
          return 1;
        }
        return 0;
      })
    });
  }

  render() {
    const journals = this.state.journals;
    return(
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

