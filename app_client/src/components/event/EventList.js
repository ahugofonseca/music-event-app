import React from 'react';
import { Row, Col, Card, Chip } from 'react-materialize';

const List = ({list}) =>
  <div>
    <Card title="Music Events" className="grey lighten-4">
      <h3>{list.day}</h3>
        {list.events.map((event, index) => {
          return (
            <Card title={event.event_type.capitalize()}>
              <Row>
                <Col m={12}><br></br></Col>
                <Col m={6} s={12}>
                  <b>Local: </b> {event.local}
                </Col>
                <Col m={6} s={12}>
                  <b>Time: </b> {event.scheduled_time}
                </Col>
              </Row>
              <Row>
                <Col m={6} s={12}>
                  <b>Music Genres: </b> <br />
                  {event.genres.map((genre) => {
                    return(<Chip>{genre.capitalize()}</Chip>)
                  })}
                </Col>
                <Col m={6} s={12}>
                  <b>Artists: </b> <br />
                  {event.music_event_artists.map((event) => {
                    return(
                      <Chip>
                        <span>{event.presentation_order}th </span>
                        {event.artist_name}
                      </Chip>
                    )
                  })}
                </Col>
              </Row>
            </Card>
          )
        })}
    </Card>
  </div>

export default List;
