import React, { Component } from 'react';
import axios from 'axios';
import List from './List';
import { Row, Col, Card } from 'react-materialize';

class Event extends Component {
  constructor(props) {
    super(props)

    this.state = {
        lists: []
    }
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

  render() {
    return (
      <Row>
        <Col m={12} s={12}>
          {this.state.lists.map( list => {
            return (<List list={list}
                          key={list.day}
                    />)
          })}
        </Col>
      </Row>
    )
  }
}

export default Event;
