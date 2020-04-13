import React from "react";
import { Col, Row} from 'react-materialize';
import { NavLink } from 'react-router-dom'


const Header = () => (
  <nav className="grey darken-2">
    <Row>
      <Col m={1}>
        <NavLink to="/">Events</NavLink>
      </Col>
    </Row>
  </nav>
);

export default Header;
