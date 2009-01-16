require 'tk'
require 'CronJobMgr'

###############################################################################
# Class: CronManager
#  This class provides the GUI interface to the CronJobMgr class.  It is the
#  view and controller objects of the MVC paradigm. 
###############################################################################
class CronManager
	#######################################################################
	# addCronJob
	#  Creates a new cron job and adds it to the cron job manager object.
	#######################################################################
	def addCronJob
		# Make sure the user has selected a command before proceeding
		if @command.value.to_s().length <= 0
			TkWarning.new("You must choose a command before " +
				"you can enter a new cron job.")
			return
		end

		# Create a new cron job and populate it
		job = CronJob.new(@minute.value, @hour.value, @day.value,
			@month.value, @weekday.value, @command.value)

		# Add the new job to the list
		@cronJobMgr.push(job)

		# Deselect any jobs previously selected in the listbox
		@cronListbox.selection_clear(0, @cronListbox.size - 1)

		# Add the new job to the list box
		@cronListbox.insert('end', job)		

		# Select the newly added job in the listbox
		@cronListbox.selection_set(@cronListbox.size - 1)
	end

	#######################################################################
	# updateCronJob
	#  Updates the current cron job.
	#######################################################################
	def updateCronJob
		# Get the index of the selected job
		index = @cronListbox.curselection()[0]

		# Use a rescue clause to make sure the user selected a job
		begin
			# Get the selected job from the cron job mananger
			job = @cronJobMgr[index]

			# Update the selected job with the chosen values
			job.minute = @minute.value
			job.hour = @hour.value
			job.day	= @day.value
			job.month = @month.value
			job.weekday = @weekday.value
			job.command = @command.value

			# Update the cron job in the listbox
			@cronListbox.delete(index)
			@cronListbox.insert(index, job)
			@cronListbox.selection_set(index)
		rescue 
			TkWarning.new("You must select a job from the list " +
				"before pressing Update")
		end		
	end

	#######################################################################
	# deleteCronJob
	#  Deletes the current cron job from the manager object.
	#######################################################################
	def deleteCronJob
		# Get the index of the selected job
		index = @cronListbox.curselection()[0]

		# Use a rescue clause to make sure the user selected a job
		begin

			# Delete the job from the listbox
			@cronListbox.delete(index)

			# Delete the job from the manager object
			@cronJobMgr.delete_at(index)

			# Set the listbox selection and detail view accordingly
			if @cronListbox.size <= 0
				resetDetailView()
			elsif index < @cronListbox.size
				@cronListbox.selection_set(index)
			else
				@cronListbox.selection_set('end')
			end
		rescue 
			TkWarning.new("You must select a job from the list " +
				"before pressing Delete")
		end
	end

	#######################################################################
	# setDetailView
	#  This method is called whenever an item from the cron jobs listbox
	#  is selected.  It sets the detail view to the attributes of the 
	#  selected cron job.
	#######################################################################
	def setDetailView
		# Get the index of the selected job
		index = @cronListbox.curselection()[0]

		begin
			# Get the cron job object
			job = @cronJobMgr[index]

			# Set the detail view to the cron job's attributes
			@minute.value = job.minute
			@hour.value = job.hour
			@day.value = job.day	
			@month.value = job.month
			@weekday.value = job.weekday
			@command.value = job.command	
		rescue 
			# This just makes sure the program doesn't crash
		end		

	end

	#######################################################################
	# resetDetailView
	#  Sets the detail view to its default values
	#######################################################################
	def resetDetailView
		@minute.value = "*"
		@hour.value = "*"
		@day.value = "*"
		@month.value = "*"
		@weekday.value = "*"
		@command.value = ""
	end

	#######################################################################
	# browseCommands
	#  Opens a dialog that allows the user to browse for, and choose, the
	#  the command they wish to add to the cron jobs list.  It then sets 
	#  the commands drop-down list with the chosen command.
	#######################################################################
	def browseCommands
		# Create a browse dialog and get the chosen command
		@command.value = Tk.getOpenFile('title'=>'Choose Command', 
			'initialdir'=>'~',
			'parent'=>@root)
	end

	#######################################################################
	# saveCronJobs
	#  Save all of the jobs in the cronJobMgr object to a text file and 
	#  add them to the cron schedule by calling crontab on the file.
	#######################################################################
	def saveCronJobs
		begin
			# Save all of the jobs to a text file
			@cronJobMgr.saveCronJobs(@filename)		
		rescue
			TkWarning.new("There was a problem saving the file " +
				"cronjobs.  Make sure you have permission " +
				"to read and write files on this system " +
				"and that you can call the crontab command.")
		end

		# Display a message that lets the user know everything is ok
		Tk.messageBox('parent'=>@root, 'default'=>'ok', 
			'type'=>'ok', 'message'=>'The save was successful ' +
			'and the cron schedule has been updated.',
			'title'=>'Save Successful')
	end

	#######################################################################
	# initialize
	#  This method creates all of the GUI components for the cron mananger
	#  and allocates actions to each of the components.
	#######################################################################
	def initialize
		# This holds the cronjobs file name
		@filename = "cronjobs"

		# Create a new cron job manager object
		@cronJobMgr = CronJobMgr.new()
			
		# Try to open the cronjobs file and load the jobs
		begin
			@cronJobMgr.loadCronJobs(@filename)
		rescue
			TkWarning.new("There was a problem loading the jobs " +
				"from the cronjobs file.  Make sure that " +
				"you have permission to read/write files.")
		end

		# Create Proc objects for each action the GUI supports
		addButtonClicked 	= proc {addCronJob}
		updateButtonClicked 	= proc {updateCronJob}
		deleteButtonClicked 	= proc {deleteCronJob}
		browseButtonClicked 	= proc {browseCommands}
		saveButtonClicked 	= proc {saveCronJobs}

		# Create a new root object
		@root = TkRoot.new() {title 'Cron Manager'}

		###
		# Create all of the components in the CronMananger
		###

		# Create frames to hold the list view and detail view 
		listViewFrm = TkFrame.new(@root).pack(
			'side'=>'left',
			'padx'=>10,
			'pady'=>10,
			'fill'=>'both')

		detailViewFrm = TkFrame.new(@root).pack(
			'side'=>'left',
			'padx'=>10,
			'pady'=>10)

		# Create a scrollbar for the cron job listbox
		scrollbar = TkScrollbar.new(listViewFrm).pack(
			'side'=>'right',
			'fill'=>'y')

		# Create the listbox to hold all of the cron jobs
		@cronListbox = TkListbox.new(listViewFrm) {
			width 	25
		}.pack(
			'fill'=>'y', 
			'expand'=>'true')

		# Bind the setDetailView method to the item selected event
		@cronListbox.bind("<ListboxSelect>") {setDetailView()}

		# Link the listbox to scrollbar
		@cronListbox.yscrollbar(scrollbar);

		# Populate the cron job listbox		
		@cronJobMgr.each { |job|
			@cronListbox.insert('end', job)
		}

		# Create all of the labels for the GUI
		labels = ['Minute', 'Hour', 'Day', 'Month', 'Weekday', 
			'Command'].collect { |label|
				TkLabel.new(detailViewFrm, 'text'=>label)
			}

		# Add each of the labels to the dialog
		labels.each_index { |i|
			labels[i].grid('column'=>0, 'row'=>i, 'sticky'=>'w')
		}		

		# Create the minute drop down list
		minutes = ['*'] + (0..59).to_a
		@minute = TkVariable.new()
		minuteOptionMenu = TkOptionMenubutton.new(
			detailViewFrm, @minute, *minutes) {
				width	1
			}.grid('column'=>1, 'row'=>0, 'sticky'=>'w', 'padx'=>5)

		# Create the hour drop down list
		hours = ['*'] + (0..23).to_a
		@hour = TkVariable.new()
		hourOptionMenu = TkOptionMenubutton.new(
			detailViewFrm, @hour, *hours) {
				width	1
			}.grid('column'=>1, 'row'=>1, 'sticky'=>'w', 'padx'=>5)

		# Create the day drop down list
		days = ['*'] + (1..31).to_a
		@day = TkVariable.new()
		dayOptionMenu = TkOptionMenubutton.new(
			detailViewFrm, @day, *days) {
				width	1
			}.grid('column'=>1, 'row'=>2, 'sticky'=>'w', 'padx'=>5)

		# Create the month drop down list
		months = ['*'] + (1..12).to_a
		@month = TkVariable.new()
		monthOptionMenu = TkOptionMenubutton.new(
			detailViewFrm, @month, *months) {
				width	1
			}.grid('column'=>1, 'row'=>3, 'sticky'=>'w', 'padx'=>5)

		# Create the weekday drop down list
		weekdays = ['*'] + (1..7).to_a
		@weekday = TkVariable.new()
		weekdayOptionMenu = TkOptionMenubutton.new(
			detailViewFrm, @weekday, *weekdays) {
				width	1
			}.grid('column'=>1, 'row'=>4, 'sticky'=>'w', 'padx'=>5)

		# Create the command textfield
		@command = TkVariable.new()
		@commandEntry = TkEntry.new(detailViewFrm) {
			width		30
			relief		'sunken'
		}.grid('column'=>1, 'row'=>5, 'sticky'=>'w', 'padx'=>5)

		# Set the textvariable, textvariable gets/sets the entry's data
		@commandEntry.textvariable(@command)

		# Create the browse for command button
		browseButton = TkButton.new(detailViewFrm) {
			text	'...'
			command	browseButtonClicked
		}.grid('column'=>2, 'row'=>5, 'sticky'=>'w')

		# Create Add, Update, Delete, and Save Buttons
		buttonFrm = TkFrame.new(detailViewFrm)
		buttonFrm.grid(
			'column'=>0, 'row'=>6, 'columnspan'=>3, 'sticky'=>'w')
		addButton = TkButton.new(buttonFrm) {
			text	'Add'
			width	7
			command	addButtonClicked
		}.pack('side'=>'left')

		updateButton = TkButton.new(buttonFrm) {
			text	'Update'
			width	7
			command updateButtonClicked
		}.pack('side'=>'left', 'padx'=>5)

		deleteButton = TkButton.new(buttonFrm) {
			text	'Delete'
			width	7
			command	deleteButtonClicked
		}.pack('side'=>'left')

		saveButton = TkButton.new(buttonFrm) {
			text	'Save'
			width	7
			command	saveButtonClicked
		}.pack('side'=>'left', 'padx'=>5)
	end
end

cronManager = CronManager.new()
Tk.mainloop()