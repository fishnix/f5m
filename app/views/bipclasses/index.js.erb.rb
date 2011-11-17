var newDiv = $(document.createElement('div'));
newDiv.html('<%= escape_javascript(render(:text => "Updated")) %>'); 
newDiv.dialog({ title: 'Updated' , modal: true, width: 'auto', heigh: 'auto' }).draggable();
