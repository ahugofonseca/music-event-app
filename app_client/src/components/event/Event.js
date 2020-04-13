import React, { Component } from 'react';
import axios from 'axios';
import EventList from './EventList';
import NewEventForm from './NewEventForm';
import { Row, Col, Card } from 'react-materialize';

class Event extends Component {
  constructor(props) {
    super(props)

    this.state = {
        lists: []
    }
    this.addNewEvent = this.addNewEvent.bind(this)
  }

  componentDidMount() {
    this.getData()
  }

  getData() {
    axios.get('api/v1/music_events')
      .then(response => {
        this.setState({
          lists: response.data
        })
      })
      .catch(error =>
        console.error(error)
      )
  }

  addNewEvent(local, scheduled_date, scheduled_time, genres, artists) {
    axios.post( '/api/v1/music_events', { music_event: {local, scheduled_date, scheduled_time, genres, artists} })
      .then(response => {
        this.setState({
          lists: response.data
        })
      })
      .catch(error => {
          console.log(error)
      })
  }

  render() {
    return (
      <Row>
        <Col m={12} s={12}>
          <NewEventForm onNewEvent={this.addNewEvent} />
        </Col>
        <Col m={12} s={12}>
          {this.state.lists.map((list, index) => {
            return (<EventList list={list}
                               key={list.day}
                    />)
          })}
        </Col>
      </Row>
    )
  }
}

export default Event;
