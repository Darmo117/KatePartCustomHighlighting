# Comment
teleport @s ~ ~5 ~
setblock ~ ~-1 ~ minecraft:emerald_block
execute at @s run setblock ~ ~-1 ~ minecraft:diamond_block

say Multi-line \
value etc.

say This is a normal non-macro command, $(key_1) is ignored
$say This is a macro line, using $(key_1)!
$teleport @s ~ ~$(key_2) ~

execute as @p run function foo:bar2 with entity @s SelectedItem
$say The player running this function is holding $(Count) items with ID $(id)!
