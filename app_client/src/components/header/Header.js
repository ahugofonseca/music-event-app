import React from "react";
import { Navbar, NavItem, Row} from 'react-materialize';
import { NavLink } from 'react-router-dom'


const Header = () => (
  <Row>
    <Navbar className="grey darken-2">
      <li><NavLink to="/">Events</NavLink></li>
    </Navbar>
  </Row>
);

export default Header;
