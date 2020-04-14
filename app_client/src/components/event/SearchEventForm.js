import React, { Component } from 'react';
import Select from 'react-select';
import { Row, Col, Button, Icon } from 'react-materialize'

class SearchEventForm extends Component {
  constructor(props) {
    super(props)

    this.state = {
      selectedOption: null,
      optionsForSelect: []
    }

    this.submit = this.submit.bind(this)
  }

  setOptionsForSelect(genresOptions) {
    if (genresOptions == null) { return [] }

    let optionsForSelect = []
    genresOptions.forEach(item => {
      optionsForSelect.push({
        value: item, label: item.capitalize()
      })
    })

    this.setState({optionsForSelect})
  }

  submit(e) {
    e.preventDefault()

    if (this.state.selectedOption) {
      this.props.onSearchEvent(this.state.selectedOption.map(item => item.value))
    } else {
      this.props.onSearchEvent(null) // Get all data without filter
    }
  }

  handleChange = selectedOption => {
    this.setState({ selectedOption });
  };

  render() {
    return (
      <div>
        <form onSubmit={this.submit}>
          <Row>
            <Col m={10}>
              <Select
                value={this.state.selectedOption}
                onChange={this.handleChange}
                placeholder="Search by Music Genres"
                isMulti
                options={this.state.optionsForSelect}
              />
            </Col>
            <Col m={2}>
              <Button large
                      waves="light"
                      type="submit"
                      style={{marginRight: '5px'}}
                      key={"search-music-events"}
                    >
                      <Icon>search</Icon>
              </Button>
            </Col>
          </Row>
        </form>
      </div>
    )
  }
}

export default SearchEventForm;
