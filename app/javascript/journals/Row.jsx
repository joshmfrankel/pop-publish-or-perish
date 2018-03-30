import React from "react"

class Row extends React.Component {
  constructor(props) {
    super(props);

    this.state = { isEditing: false };

    this.toggleEditMode = this.toggleEditMode.bind(this);
  }

  toggleEditMode(e) {
    this.setState({ isEditing: !this.state.isEditing });
  }

  displayRowData(data) {
    if (this.state.isEditing) {
      return <input value={data} />;
    }
    return data;
  }

  render() {
    const journal = this.props.journal;

    return (
      <tr>
        <td>{this.displayRowData(journal.title)}</td>
        <td>{this.displayRowData(journal.description)}</td>
        <td>{this.displayRowData(journal.impact_factor)}</td>
        <td onClick={this.toggleEditMode}>Edit</td>
      </tr>
    );
  }
}

export default Row;
