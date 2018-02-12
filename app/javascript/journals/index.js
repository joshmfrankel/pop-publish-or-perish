import React from "react"
import ReactDOM from "react-dom"

class JournalListing extends React.Component {
  render() {
    const journals = this.props.journals;

    return(
      <tbody>
        {journals.map((journal) =>
          <tr key={journal.id}>
            <td>{journal.title}</td>
            <td>{journal.description}</td>
            <td>{journal.impact_factor}</td>
          </tr>
        )}
      </tbody>
    );
  }
}

document.addEventListener('DOMContentLoaded', () => {
  const journalsNode = document.getElementById("journals_listing")
  const journalsListingData = JSON.parse(journalsNode.getAttribute("data"))

  ReactDOM.render(
    <JournalListing journals={journalsListingData} />,
    document.body.appendChild(document.createElement('table')),
  )
})

