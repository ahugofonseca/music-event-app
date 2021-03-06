import React, { Component } from 'react';
import { Row, Col, Card, Button, Icon, Select, Chip } from 'react-materialize';
import DynamicMultipleInput from '../custom_form/DynamicMultipleInput'

// const NewEventForm = ({onNewEvent = f => f}) => {
class NewEventForm extends Component {
  constructor(props) {
    super(props)

    this.state = {
      local: '',
      scheduled_date: '',
      scheduled_time: '',
      genres: [],
      artists: [],
      childFields: 1
    }

    this.submit = this.submit.bind(this)
    this.getDataFields = this.getDataFields.bind(this)
    this.sendRequest = this.sendRequest.bind(this)
    this.resetDataFields = this.resetDataFields.bind(this)
  }

    submit(e) {
      e.preventDefault()

      this.sendRequest(this.resetDataFields)
    }

    sendRequest() {
      this.props.onNewEvent(
        this.state.local.value,
        this.state.scheduled_date.value,
        this.state.scheduled_time.value,
        this.state.genres,
        this.state.artists
      )
    }

    resetDataFields() {
      this.setState({
        local: '',
        scheduled_date: '',
        scheduled_time: '',
        genres: [],
        artists: [],
        childFields: 1
      })

      let form = document.getElementById('new_event_form');
      let inputs = form.getElementsByTagName("input");

      for (var item of inputs) {
        item.value = ''
      }


      this.refs.genres.resetFields()
      this.refs.artists.resetFields()
    }

    getDataFields(fieldsData) {
      let keys = Object.keys(fieldsData[0])

      if (keys.includes('genres')) {
        this.setState({
          genres: fieldsData
        })
      } else {
        this.setState({
          artists: fieldsData
        })
      }

      this.setState({
        childFields: this.state.childFields + 1
      })

      let button = document.getElementById('new_event_button');

      if (this.state.childFields == 2) {
        button.disabled = false
        button.classList.remove("disabled");
      }
    }

    render() {
      return (
        <Card title="New event">
          <form onSubmit={this.submit} id="new_event_form">
            <Row>
              <Col m={6} s={12}>
                <label htmlFor="scheduled_date">Event Date:</label>
                <input  ref={input => this.state.scheduled_date = input}
                        type="date"
                        id="scheduled_date"
                        placeholder="20/10/2020" required />
              </Col>
              <Col m={6} s={12}>
                <label htmlFor="scheduled_time">Event Time:</label>
                <input  ref={input => this.state.scheduled_time = input}
                        type="time"
                        id="scheduled_time"
                        placeholder="20:30:00" required />
              </Col>
              <Col m={12} s={12}>
                <input  ref={input => this.state.local = input}
                        id="local"
                        type="text"
                        placeholder="Local..." required />
              </Col>

              <Col m={12}><br></br></Col>
              <Col m={6}>
                <p><b>Music Genres:</b></p>
                <DynamicMultipleInput
                  field={['genres']}
                  ref="genres"
                  getDataFields={this.getDataFields}
                />
              </Col>
              <Col m={6}>
                <p><b>Artists:</b></p>
                <DynamicMultipleInput
                  field={['order', 'artist']}
                  getDataFields={this.getDataFields}
                  ref="artists"
                />
              </Col>
            </Row>
            <br />
            <div className="right-align">
              <Button node="button"
                      type="submit"
                      waves="light"
                      id="new_event_button"
                      disabled={true}
              >
                Create event <Icon right>send</Icon>
              </Button>
            </div>
          </form>
        </Card>
      )
    }
}

export default NewEventForm;
