frame .com
label .com.label -text "Enter command: "
entry .com.ent -width 30
button .com.button1 -text "Execute" -command {orale}
button .com.button2 -text "Clear" -command {del_frame}

frame .tx
text .tx.text -yscrollcommand ".tx.scroll set"
scrollbar .tx.scroll -command ".tx.text yview"
 

pack .com
pack .com.label .com.ent .com.button1 .com.button2 -side left
pack .tx.scroll -side right -fill y
pack .tx.text -side left 
pack .tx -side bottom
 
focus .com.ent

bind all <Return> {
   orale
}

bind all <Alt-e> {
   del_frame
}

proc orale {} {
   set command [.com.ent get]
   if {$command == ""} {
      tk_messageBox -icon error -message "Please insert a command" \
                   -parent . -title Error 
      
   } 
   set result [eval exec $command]
   file_write prueba.s $result
   read_into_text .tx.text prueba.s
   #.tx.text insert 1.0 "$result" 
   .com.ent delete 0 end
}                       


proc del_frame {} {
   .tx.text delete 1.0 end
}

proc file_write { filename data } {
   return [catch {
      set fileid [open $filename "w"]
      puts -nonewline $fileid $data
      close $fileid
   }]
}

proc read_file { filename } {
   set data ""
   if { [file readable $filename] } {
      set fileid [open $filename "r"]
      set data [read $fileid]
      close $fileid
   }
   return $data
}

proc read_into_text { textwidget filename } {
   set data [read_file $filename]
   if { $data != "" } {
      $textwidget delete 1.0 end
      $textwidget insert end $data
   }
}


#proc tkerror {errmesg} {

#}
