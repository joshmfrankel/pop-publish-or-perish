import React from "react"
// import debounce from 'lodash.debounce';

class Row extends React.Component {
  constructor(props) {
    super(props);

    this.state = {
      isEditing: false,
      journal: {
        title: props.journal.title,
        description: props.journal.description,
        impact_factor: props.journal.impact_factor,
      }
    };

    this.toggleEditMode = this.toggleEditMode.bind(this);
    this.handleChange = debounce(this.handleChange.bind(this), 250);
  }

  toggleEditMode() {
    this.setState({ isEditing: !this.state.isEditing });
  }

  handleChange(event) {
    this.setState({
      journal: {
        ...this.state.journal,
        [event.target.name]: event.target.value
      }
    }, function() {
      fetch('journals/' + this.props.journal.id, {
        method: "PATCH",
        headers: {
          'Content-Type': 'application/json',
          'X-CSRF-Token': this.props.token
        },
        credentials: 'same-origin',
        body: JSON.stringify(this.state.journal),
      });
    });
  }

  displayRowData(data, name) {
    if (this.state.isEditing) {
      return <input
        defaultValue={data}
        onChange={this.handleChange}
        name={name}
      />;
    }
    return data;
  }

  render() {
    const journal = this.state.journal;

    return (
      <tr>
        <td>{this.displayRowData(journal.title, "title")}</td>
        <td>{this.displayRowData(journal.description, "description")}</td>
        <td>{this.displayRowData(journal.impact_factor, "impact_factor")}</td>
        <td onClick={this.toggleEditMode}>Edit</td>
        <td onClick={this.removeJournal}>Delete</td>
      </tr>
    );
  }
}

export default Row;
