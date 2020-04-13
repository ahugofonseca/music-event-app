import React, { Component } from 'react';
import axios from 'axios';
import EventList from './EventList';
import NewEventForm from './NewEventForm';
import SearchEventForm from './SearchEventForm';
import { Row, Col, Card, Collapsible, CollapsibleItem, Icon} from 'react-materialize';

class Event extends Component {
  constructor(props) {
    super(props)

    this.state = {
        lists: []
    }
    this.addNewEvent = this.addNewEvent.bind(this)
    this.searchEvent = this.searchEvent.bind(this)
    this.getData = this.getData.bind(this)
  }

  componentDidMount() {
    this.getData()
  }

  getData(filters=null) {
    let url = 'api/v1/music_events?client_time_zone='+this.getTimeZone()

    if (filters) {
      filters.forEach((item, index) => {
        url += '&filters[genres][]='+item
        if (filters.size -1 > index) { url += '&'}
      })
    }

    axios.get(url)
      .then(response => {
        this.setState({
          lists: response.data.data
        })

        let genresOptions = response.data.search_options[0].genres
        this.refs.SearchEventComponent.setOptionsForSelect(genresOptions)
      })
      .catch(error =>
        console.error(error)
      )
  }

  addNewEvent(local, scheduled_date, scheduled_time, genres, artists) {
    axios.post('/api/v1/music_events', { music_event: {client_time_zone: this.getTimeZone(), local, scheduled_date, scheduled_time, genres, artists} })
      .then(response => {
        this.setState({
          lists: response.data.data
        })

        this.refs.NewEventForm.resetDataFields()

        let genresOptions = response.data.search_options[0].genres
        this.refs.SearchEventComponent.setOptionsForSelect(genresOptions)
      })
      .catch(error => {
          console.error(error)
      })
  }

  searchEvent(filters) {
    this.getData(filters)
  }

  getTimeZone() {
    function z(n) { return (n < 10 ? '0' : '') + n }

    let offset = new Date().getTimezoneOffset();
    let sign = offset < 0 ? '+' : '-';
    offset = Math.abs(offset);
    return sign + z(offset/60 | 0) + z(offset%60);
  }

  render() {
    return (
      <Row>
        <Col m={12} s={12}>
          <NewEventForm onNewEvent={this.addNewEvent} ref="NewEventForm" />
        </Col>
        <Col m={12} s={12}>
          <Card>
            <SearchEventForm ref="SearchEventComponent"
              onSearchEvent={this.searchEvent}
              genresOptions={this.state.searchOptions}
            />
          </Card>

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
