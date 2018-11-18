import React from "react";

class Modal extends React.Component {
  constructor(props) {
    super(props);

    this.state = {
      record: this.props.currentRecord;
    }
  }

  render() {
    const { currentRecord } = this.state;
    return (
      <div className="Modal">
        <div className="Modal-container">
          <div className="Modal-header">
            <h2>{this.props.title}</h2>
          </div>

          <div className="Modal-content">
            <label htmlFor="title">
              Title
              <input
                defaultValue={ currentRecord.title }
                name="title"
                id="title"
              />
            </label>
            <label htmlFor="impact_factor">
              Impact Factor
              <input
                defaultValue={ currentRecord.impact_factor }
                name="impact_factor"
                id="impact_factor"
              />
            </label>
          </div>

          <div className="Modal-actions">
            <button onClick={this.props.onCloseModal} className="Modal-cancel">Cancel</button>
            <button onClick={this.props.onSubmitModal} className="Modal-submit">Submit</button>
          </div>
        </div>
      </div>
    );
  }
}

export default Modal;
