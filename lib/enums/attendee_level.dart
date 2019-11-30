import 'package:flutter/material.dart';

enum AttendeeLevel { Betrothed, WeddingParty, AllGuests }

List<DropdownMenuItem<AttendeeLevel>> attendeeLevelDropdown = [
  DropdownMenuItem(
    value: AttendeeLevel.Betrothed,
    child: Text('Betrothed Only'),
  ),
  DropdownMenuItem(
    value: AttendeeLevel.WeddingParty,
    child: Text('Weddding Party Only'),
  ),
  DropdownMenuItem(
    value: AttendeeLevel.AllGuests,
    child: Text('All Guests'),
  )
];
