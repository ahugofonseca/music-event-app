import React from 'react';
import { Row, Col, Card, Table, Modal, Button, Icon, Chip } from 'react-materialize';

const List = ({list}) =>
  <div>
    <Card title="Music Events">
      <h3>{list.day}</h3>
      <Table>
        <thead>
          <tr>
            <th data-field="local">
              Local
            </th>
            <th data-field="schedule">
              In Your Time Zone
            </th>
            <th data-field="details">
            </th>
          </tr>
        </thead>
        <tbody>
          {list.events.map(event => {
            return (
              <tr>
                <td>
                  {event.local}
                </td>
                <td>
                  {new Date(event.scheduled_date_time).toString()}
                </td>
                <td>
                  <div>
                    <Button
                      className="modal-trigger"
                      href="#event-details"
                      node="button"
                    >
                       Show Details
                    </Button>
                    <Modal
                      actions={[
                        <Button flat modal="close" node="button" waves="green">Close</Button>
                      ]}
                      bottomSheet={false}
                      fixedFooter={false}
                      header="Festival"
                      id="event-details"
                      open={false}
                      options={{
                        dismissible: true,
                        endingTop: '10%',
                        inDuration: 250,
                        onCloseEnd: null,
                        onCloseStart: null,
                        onOpenEnd: null,
                        onOpenStart: null,
                        opacity: 0.5,
                        outDuration: 250,
                        preventScrolling: true,
                        startingTop: '4%'
                      }}
                    >
                      <div>
                        <Row>
                          <Col m={6} s={12}>
                            <Card title="Music Genres">
                              {event.genres.map((genre) => {
                                return(<Chip>{genre}</Chip>)
                              })}
                            </Card>
                          </Col>
                          <Col m={6} s={12}>
                            <Card title="Artists">
                              {event.artists.map((artist) => {
                                return(<li>{artist.name}</li>)
                              })}
                            </Card>
                          </Col>
                        </Row>
                      </div>
                    </Modal>
                    </div>
                </td>
              </tr>
            )
          })}
        </tbody>
      </Table>
    </Card>
  </div>

export default List;
