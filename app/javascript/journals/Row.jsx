import React from "react"

class Row extends React.Component {
  render() {
    const journal = this.props.journal;
    return (
      <tr>
        <td>{journal.title}</td>
        <td>{journal.description}</td>
        <td>{journal.impact_factor}</td>
        <td>Edit</td>
      </tr>
    );
  }
}

export default Row;
