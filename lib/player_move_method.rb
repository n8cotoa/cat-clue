#
# if roll > 0
#   if new_space is in available_spaces
#     if current_space is a door
#       nearby_room = the room the door opens
#       if new_space is in nearby_room
#         allow guess, update new_space and original_space, roll, update roll
#       elsif # if new_space is not in nearby_room
#         update new_space and original_space, roll, update roll
#       end
#     else # if current_space is not a door
#       update new_space and original_space, roll, update roll
#     end
#   elsif new_space is in nearby_room # new_space is in nearby_room
#
# ## Round two
# if roll > 0
#   if current_space is a door
#     nearby_room = the room the door opens
#     if new_space is in a room
#       allow guess, update new_space and original_space, roll, update roll
#     elsif new_space is in available_spaces
#       update new_space and original_space, roll, update roll
#     end
#   elsif available_spaces includes new_space
#   elsif current_space and new_space are both in the room
#
# #
# def available_spaces(current_coords)
#   ## Setup
#   kitchen = ['A1', 'A2', 'B1', 'B2']
#   hall = ['A5', 'A6', 'B5', 'B6']
#   lounge = ['A9', 'A10', 'B9', 'B10']
#   library = ['E1', 'E2', 'F1', 'F2']
#   cellar = ['E5', 'E6', 'F5', 'F6']
#   pool = ['E9', 'E10', 'F9', 'F10']
#   laboratory = ['I1', 'I2', 'J1', 'J2']
#   dining = ['I5', 'I6', 'J5', 'J6']
#   study = ['I9', 'I10', 'J9', 'J10']
#   rooms_hash = {0 => 'Kitchen', 1 => 'Hall', 2 => 'Lounge', 3 => 'Library', 4 => 'Cellar', 5 => 'Pool Room', 6 => 'Laboratoy', 7 => 'Dining Room', 8 => 'Study'}
#   rooms = [kitchen, hall, lounge, library, cellar, pool, laboratory, dining, study]
#   all_room_spaces = kitchen + hall + lounge + library + cellar + pool + laboratory + dining + study
#   empty_spaces = Space.where(player_id: nil).all
#   empty_room_spaces = all_room_spaces & empty_spaces
#   current_space = Space.find_by(coordinates: current_coords)
#   player_x_axis = current_coords.split('', 2)[0]
#   player_y_axis = current_coords.split('', 2)[1]
#   available_spaces = []
#   available_coords = []
#   empty_halls = Space.where(space_type: 'space', player_id: nil)
#   doors = Space.where('space_type LIKE ?', '%Door').all
#   empty_room_spaces = []
#   rooms.each do |room|
#     room.each do |room_space|
#       if room_space.player_id == nil
#         empty_room_spaces.push(room_space)
#       end
#     end
#   end
#   ## Check which type of space current_coords is with if statement
#   if current_space.space_type == 'space'
#     available_spaces = empty_halls + empty_doors
#     available_spaces.each do |space|
#       space_x_axis = space.coordinates.split('', 2)[0]
#       space_y_axis = space.coordinates.split('', 2)[1]
#       ## (if on the y axis it's 1 away, and the x-axis is the same) XOR vice versa
#       if (((player_y_axis.to_i - space_y_axis.to_i).abs == 1) && (letters.index(player_x_axis) == letters.index(space_x_axis))) ^ (((letters.index(player_x_axis) - letters.index(space_x_axis)).abs == 1) && (player_y_axis.to_i == space_y_axis.to_i))
#         available_coords.push(space.coordinates)
#   elsif doors.include?(current_space) ## could dry up by not specifying which room. As long as the requirement is there for new_spaces to be one away, available_spaces only needs to be empty_halls + empty_rooms. Rooms don't need to take into account which room is nearby
#     # nearby_room = current_space.space_type.split(" Door")[0]
#     # room_index = rooms_hash.index(nearby_room)
#     # nearby_room_spaces = rooms[room_index]
#     # empty_nearby_room_spaces = nearby_room_spaces & empty_room_spaces
#     available_spaces = empty_halls + empty_room_spaces
#     available_spaces.each do |space|
#       space_x_axis = space.coordinates.split('', 2)[0]
#       space_y_axis = space.coordinates.split('', 2)[1]
#       if (((player_y_axis.to_i - space_y_axis.to_i).abs == 1) && (letters.index(player_x_axis) == letters.index(space_x_axis))) ^ (((letters.index(player_x_axis) - letters.index(space_x_axis)).abs == 1) && (player_y_axis.to_i == space_y_axis.to_i))
#         available_coords.push(space.coordinates)
#   elsif all_room_spaces.include?(current_space) # Lastly, if you're on a room,
#     available_spaces = empty_room_spaces + all_door_spaces
#     available_spaces.each do |space|
#       space_x_axis = space.coordinates.split('', 2)[0]
#       space_y_axis = space.coordinates.split('', 2)[1]
#       if (((player_y_axis.to_i - space_y_axis.to_i).abs == 1) && (letters.index(player_x_axis) == letters.index(space_x_axis))) ^ (((letters.index(player_x_axis) - letters.index(space_x_axis)).abs == 1) && (player_y_axis.to_i == space_y_axis.to_i))
#         available_coords.push(space.coordinates)
#       end
#     end
#   end
#   available_coords
# end
#
# # def move(new_coords)
# #   # Setup
# #   roll = self.dice_roll
# #   original_space = Space.find_by(player_id: self.id)
# #   original_coords = original_space.coordinates
# #   available_spaces = self.available_spaces(original_coords)
# #   new_space = Space.find(coordinates: new_coords)
# #   doors = Space.where('space_type LIKE ?', '%Door').all
# #   rooms_hash = {0 => 'Kitchen', 1 => 'Hall', 2 => 'Lounge', 3 => 'Library', 4 => 'Cellar', 5 => 'Pool Room', 6 => 'Laboratoy', 7 => 'Dining Room', 8 => 'Study'}
# #   kitchen = ['A1', 'A2', 'B1', 'B2']
# #   hall = ['A5', 'A6', 'B5', 'B6']
# #   lounge = ['A9', 'A10', 'B9', 'B10']
# #   library = ['E1', 'E2', 'F1', 'F2']
# #   cellar = ['E5', 'E6', 'F5', 'F6']
# #   pool = ['E9', 'E10', 'F9', 'F10']
# #   laboratory = ['I1', 'I2', 'J1', 'J2']
# #   dining = ['I5', 'I6', 'J5', 'J6']
# #   study = ['I9', 'I10', 'J9', 'J10']
# #   rooms = [kitchen, hall, lounge, library, cellar, pool, laboratory, dining, study]
# #   # If statements
# #   if roll > 0
# #     if available_spaces.include?(new_space)
# #       if doors.includes(original_space)
# #         door_string = original_space.space_type
# #         nearby_room = door_string.split(" Door")[0]
# #         room_index = rooms_hash.index(nearby_room)
# #         nearby_room_spaces = rooms[room_index]
# #         if nearby_room_spaces.include?(new_space)
# #           new_space.update(player_id: self.id)
# #           original_space.update(player_id: nil)
# #           guess_allowed = true
# #           roll -= 1
# #           self.update(dice_roll: roll)
# #         else # new_space is not in nearby_room
# #           new_space.update(player_id: self.id)
# #           original_space.update(player_id: nil)
# #           roll -= 1
# #           self.update(dice_roll: roll)
# #         end
# #       end
# #     end
# #   end
# # end
