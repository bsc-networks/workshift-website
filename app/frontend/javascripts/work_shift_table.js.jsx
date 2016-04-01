/** @jsx React.DOM */
'use strict'

var React = require('react')

var columnMeta = [
  {
  "columnName": "shift",
  "displayName": "Work Shift",
  "order": 1,
  "locked": false,
  "visible": true,
  //"customComponent": DescriptionComponent
  },
  {
  "columnName": "user",
  "displayName": "User",
  "order": 4,
  //"customComponent": UserComponent
  },
  {
  "columnName": "start_time",
  "displayName": "Start Time",
  "order" :2
  },
  {
  "columnName": "end_time",
  "displayName": "End Time",
  "order" :3
  },
  {
  "columnName": "description",
  "displayName": "Description",
  "order" :5
  },
];




var WorkShiftTable = React.createClass({
  propTypes: {
    title: React.PropTypes.string,
    //shifts: React.PropTypes.array
  },
  
  getInitialState: function() {
   return {shiftData: [
     {
    "shift": "Pans",
    "user": "Mayer Leonard",
    "start_time": "2PM",
    "end_time": "3PM",
    "description": "Pans description"
  },
  {
    "shift": "Kitchen",
    "user": "Mom",
    "start_time": "3PM",
    "end_time": "5PM",
    "description": "Kitchen description"
  },
  ]}
  },
  
  componentDidMount: function(){
    var shifts = this.props.shifts
    var data = []
    for (var i = 0; i < shifts.length; i++){
      var shift = shifts[i]
      data.push({"shift": shift.metashift.category,
        "user": shift.user.first_name +" "+ shift.user.last_name,
        "start_time": shift.start_time, 
        "end_time": shift.end_time
      })
    }
    if (shifts.length > 0) {
      this.setState({shiftData: data})
    } else{
      
    }
  },
  
  render: function(){
    return (
        <div> Hello from react land!</div>
      );
  }

  // render: function() {
  //   return (
  //     <div>
  //       <Griddle results={this.state.shiftData}
  //       columnMetadata={columnMeta}
  //       showFilter={true}/>
  //     </div>
  //   );
  // }
});

var hello = function(){
  run: console.log("Hello world");
}
module.exports = WorkShiftTable
//module.exports(hello)
