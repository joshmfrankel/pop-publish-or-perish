import React from "react";

class Modal extends React.Component {
  constructor(props) {
    super(props);

    this.state = {
      record: this.props.currentRecord,
    }

    this.onUpdateInput = this.onUpdateInput.bind(this);
    this.onSubmitModal = this.onSubmitModal.bind(this);
  }

  onUpdateInput(event) {
    this.setState({
      record: {
        ...this.state.record,
        [event.target.name]: event.target.value,
      }
    });
  }

  // https://github.com/github/fetch/issues/424
  onSubmitModal() {
    fetch('journals/' + this.state.record.id, {
      method: 'PUT',
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'X-CSRF-Token': this.props.token,
        'X-Requested-With': 'XMLHttpRequest'
      },
      credentials: 'same-origin',
      body: JSON.stringify({
        journal: this.state.record
      })
    }).then(() => {

      // Ensure to update the listing's state
      this.props.onSubmit(this.state.record);

      // Close the modal
      this.props.onCloseModal();
    });
  }

  render() {
    const { modalTitle } = this.props;
    const { record } = this.state;

    return (
      <div className="Modal">
        <div className="Modal-container">
          <div className="Modal-header">
            <h2>{modalTitle}</h2>
          </div>

          <div className="Modal-content">
            <label htmlFor="title">
              Title
              <input
                defaultValue={ record.title }
                name="title"
                id="title"
                onChange={this.onUpdateInput}
              />
            </label>
            <label htmlFor="impact_factor">
              Impact Factor
              <input
                defaultValue={ record.impact_factor }
                name="impact_factor"
                id="impact_factor"
                onChange={this.onUpdateInput}
              />
            </label>
          </div>

          <div className="Modal-actions">
            <button onClick={this.props.onCloseModal} className="Modal-cancel">Cancel</button>
            <button onClick={this.onSubmitModal} className="Modal-submit">Submit</button>
          </div>
        </div>
      </div>
    );
  }
}

export default Modal;
