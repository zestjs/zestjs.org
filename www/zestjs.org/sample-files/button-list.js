define(['./button6'], function(Button) {
  return {
    options: {
      buttonList: ['Some', 'buttons']
    },
    load: function(o) {
      o.listStructure = o.buttonList.map(function(title) {
        return {
          render: Button,
          options: {
            text: title,
            msg: 'clicked ' + title
          }
        };
      });
    },
    render: function(o) {
      return "<div>{`listStructure`}</div>";
    }
  };
});