import React from "react";
import Event from "./components/event/Event";
import { Container } from 'react-materialize';
import { Switch, Route } from 'react-router-dom'

const Main = () => (
  <main>
    <Container>
      <Switch>
        <Route exact path='/' component={Event} />
      </Switch>
    </Container>
  </main>
);

export default Main;
