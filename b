[braca@bvm:~/develop/rails/cjproject/app/controllers]$cd ..
[braca@bvm:~/develop/rails/cjproject/app]$cd ..
[braca@bvm:~/develop/rails/cjproject]$rails c
Loading development environment (Rails 4.0.0)
irb(main):001:0> g = Games.find(6)
NameError: uninitialized constant Games
	from (irb):1
	from /usr/lib/ruby/gems/1.9.1/gems/railties-4.0.0/lib/rails/commands/console.rb:90:in `start'
	from /usr/lib/ruby/gems/1.9.1/gems/railties-4.0.0/lib/rails/commands/console.rb:9:in `start'
	from /usr/lib/ruby/gems/1.9.1/gems/railties-4.0.0/lib/rails/commands.rb:64:in `<top (required)>'
	from bin/rails:4:in `require'
	from bin/rails:4:in `<main>'
irb(main):002:0> g = Game.find(6)
  Game Load (39.0ms)  SELECT "games".* FROM "games" WHERE "games"."id" = ? LIMIT 1  [["id", 6]]
=> #<Game id: 6, jambgame: "\x04\bo:\tJamb\a:\v@cells[\x16[\to:\tCell\t:\n@type:\nLABEL:\v@valu...", user_id: nil, created_at: "2013-07-27 17:30:29", updated_at: "2013-07-27 17:30:29">
irb(main):003:0>
irb(main):004:0* j = g.to_jamb
=> #<Jamb:0x00000004ddead8 @cells=[[cell type LABEL  @value X @enabled false, cell type LABEL  @value DOWN @enabled false, cell type LABEL  @value UP @enabled false, cell type LABEL  @value FREE @enabled false], [cell type LABEL  @value 1 @enabled false, cell type NORMAL  @value  @enabled true, cell type NORMAL  @value  @enabled false, cell type NORMAL  @value  @enabled true], [cell type LABEL  @value 2 @enabled false, cell type NORMAL  @value  @enabled false, cell type NORMAL  @value  @enabled false, cell type NORMAL  @value  @enabled true], [cell type LABEL  @value 3 @enabled false, cell type NORMAL  @value  @enabled false, cell type NORMAL  @value  @enabled false, cell type NORMAL  @value  @enabled true], [cell type LABEL  @value 4 @enabled false, cell type NORMAL  @value  @enabled false, cell type NORMAL  @value  @enabled false, cell type NORMAL  @value  @enabled true], [cell type LABEL  @value 5 @enabled false, cell type NORMAL  @value  @enabled false, cell type NORMAL  @value  @enabled false, cell type NORMAL  @value  @enabled true], [cell type LABEL  @value 6 @enabled false, cell type NORMAL  @value  @enabled false, cell type NORMAL  @value  @enabled false, cell type NORMAL  @value  @enabled true], [cell type LABEL  @value Bon @enabled false, cell type CALC  @value  @enabled false, cell type CALC  @value  @enabled false, cell type CALC  @value  @enabled false], [cell type LABEL  @value SUM @enabled false, cell type CALC  @value  @enabled false, cell type CALC  @value  @enabled false, cell type CALC  @value  @enabled false], [cell type LABEL  @value Mx @enabled false, cell type NORMAL  @value  @enabled false, cell type NORMAL  @value  @enabled false, cell type NORMAL  @value  @enabled true], [cell type LABEL  @value Mn @enabled false, cell type NORMAL  @value  @enabled false, cell type NORMAL  @value  @enabled false, cell type NORMAL  @value  @enabled true], [cell type LABEL  @value DIF @enabled false, cell type CALC  @value  @enabled false, cell type CALC  @value  @enabled false, cell type CALC  @value  @enabled false], [cell type LABEL  @value K @enabled false, cell type NORMAL  @value  @enabled false, cell type NORMAL  @value  @enabled false, cell type NORMAL  @value  @enabled true], [cell type LABEL  @value F @enabled false, cell type NORMAL  @value  @enabled false, cell type NORMAL  @value  @enabled false, cell type NORMAL  @value  @enabled true], [cell type LABEL  @value P @enabled false, cell type NORMAL  @value  @enabled false, cell type NORMAL  @value  @enabled false, cell type NORMAL  @value  @enabled true], [cell type LABEL  @value J @enabled false, cell type NORMAL  @value  @enabled false, cell type NORMAL  @value  @enabled true, cell type NORMAL  @value  @enabled true], [cell type LABEL  @value SUM @enabled false, cell type CALC  @value  @enabled false, cell type CALC  @value  @enabled false, cell type CALC  @value  @enabled false]], @diceboard=#<DiceBoard:0x0000000329ad30 @dices=[nil, nil, nil, nil, nil, nil], @selected=[false, false, false, false, false, false]>>
irb(main):005:0> j.cel(1,1).value
NoMethodError: undefined method `cel' for #<Jamb:0x00000004ddead8>
	from (irb):5
	from /usr/lib/ruby/gems/1.9.1/gems/railties-4.0.0/lib/rails/commands/console.rb:90:in `start'
	from /usr/lib/ruby/gems/1.9.1/gems/railties-4.0.0/lib/rails/commands/console.rb:9:in `start'
	from /usr/lib/ruby/gems/1.9.1/gems/railties-4.0.0/lib/rails/commands.rb:64:in `<top (required)>'
	from bin/rails:4:in `require'
	from bin/rails:4:in `<main>'
irb(main):006:0> j.cell(1,1).value
=> nil
irb(main):007:0> j.set_cell_value(1,1,3)
=> [7, 8, 11]
irb(main):008:0> j.cell(1,1).value
=> 3
irb(main):009:0> g.from_jamb(j)
=> "\x04\bo:\tJamb\a:\v@cells[\x16[\to:\tCell\t:\n@type:\nLABEL:\v@valueI\"\x06X\x06:\x06EF:\r@enabledF:\f@is_colFo;\a\t;\b;\t;\nI\"\tDOWN\x06;\vF;\fF;\rFo;\a\t;\b;\t;\nI\"\aUP\x06;\vF;\fF;\rFo;\a\t;\b;\t;\nI\"\tFREE\x06;\vF;\fF;\rF[\to;\a\t;\b;\t;\nI\"\x061\x06;\vF;\fF;\rFo;\a\t;\b:\vNORMAL;\ni\b;\fF;\rFo;\a\t;\b;\x0E;\n0;\fF;\rFo;\a\t;\b;\x0E;\n0;\fT;\rF[\to;\a\t;\b;\t;\nI\"\x062\x06;\vF;\fF;\rFo;\a\t;\b;\x0E;\n0;\fT;\rFo;\a\t;\b;\x0E;\n0;\fF;\rFo;\a\t;\b;\x0E;\n0;\fT;\rF[\to;\a\t;\b;\t;\nI\"\x063\x06;\vF;\fF;\rFo;\a\t;\b;\x0E;\n0;\fF;\rFo;\a\t;\b;\x0E;\n0;\fF;\rFo;\a\t;\b;\x0E;\n0;\fT;\rF[\to;\a\t;\b;\t;\nI\"\x064\x06;\vF;\fF;\rFo;\a\t;\b;\x0E;\n0;\fF;\rFo;\a\t;\b;\x0E;\n0;\fF;\rFo;\a\t;\b;\x0E;\n0;\fT;\rF[\to;\a\t;\b;\t;\nI\"\x065\x06;\vF;\fF;\rFo;\a\t;\b;\x0E;\n0;\fF;\rFo;\a\t;\b;\x0E;\n0;\fF;\rFo;\a\t;\b;\x0E;\n0;\fT;\rF[\to;\a\t;\b;\t;\nI\"\x066\x06;\vF;\fF;\rFo;\a\t;\b;\x0E;\n0;\fF;\rFo;\a\t;\b;\x0E;\n0;\fF;\rFo;\a\t;\b;\x0E;\n0;\fT;\rF[\to;\a\t;\b;\t;\nI\"\bBon\x06;\vF;\fF;\rTo;\a\t;\b:\tCALC;\n0;\fF;\rFo;\a\t;\b;\x0F;\n0;\fF;\rFo;\a\t;\b;\x0F;\n0;\fF;\rF[\to;\a\t;\b;\t;\nI\"\bSUM\x06;\vF;\fF;\rTo;\a\t;\b;\x0F;\n0;\fF;\rFo;\a\t;\b;\x0F;\n0;\fF;\rFo;\a\t;\b;\x0F;\n0;\fF;\rF[\to;\a\t;\b;\t;\nI\"\aMx\x06;\vF;\fF;\rFo;\a\t;\b;\x0E;\n0;\fF;\rFo;\a\t;\b;\x0E;\n0;\fF;\rFo;\a\t;\b;\x0E;\n0;\fT;\rF[\to;\a\t;\b;\t;\nI\"\aMn\x06;\vF;\fF;\rFo;\a\t;\b;\x0E;\n0;\fF;\rFo;\a\t;\b;\x0E;\n0;\fF;\rFo;\a\t;\b;\x0E;\n0;\fT;\rF[\to;\a\t;\b;\t;\nI\"\bDIF\x06;\vF;\fF;\rTo;\a\t;\b;\x0F;\n0;\fF;\rFo;\a\t;\b;\x0F;\n0;\fF;\rFo;\a\t;\b;\x0F;\n0;\fF;\rF[\to;\a\t;\b;\t;\nI\"\x06K\x06;\vF;\fF;\rFo;\a\t;\b;\x0E;\n0;\fF;\rFo;\a\t;\b;\x0E;\n0;\fF;\rFo;\a\t;\b;\x0E;\n0;\fT;\rF[\to;\a\t;\b;\t;\nI\"\x06F\x06;\vF;\fF;\rFo;\a\t;\b;\x0E;\n0;\fF;\rFo;\a\t;\b;\x0E;\n0;\fF;\rFo;\a\t;\b;\x0E;\n0;\fT;\rF[\to;\a\t;\b;\t;\nI\"\x06P\x06;\vF;\fF;\rFo;\a\t;\b;\x0E;\n0;\fF;\rFo;\a\t;\b;\x0E;\n0;\fF;\rFo;\a\t;\b;\x0E;\n0;\fT;\rF[\to;\a\t;\b;\t;\nI\"\x06J\x06;\vF;\fF;\rFo;\a\t;\b;\x0E;\n0;\fF;\rFo;\a\t;\b;\x0E;\n0;\fT;\rFo;\a\t;\b;\x0E;\n0;\fT;\rF[\to;\a\t;\b;\t;\nI\"\bSUM\x06;\vF;\fF;\rTo;\a\t;\b;\x0F;\n0;\fF;\rFo;\a\t;\b;\x0F;\n0;\fF;\rFo;\a\t;\b;\x0F;\n0;\fF;\rF:\x0F@diceboardo:\x0EDiceBoard\a:\v@dices[\v000000:\x0E@selected[\vFFFFFF"
irb(main):010:0> g.save!
   (0.4ms)  begin transaction
  SQL (2.6ms)  UPDATE "games" SET "jambgame" = ?, "updated_at" = ? WHERE "games"."id" = 6  [["jambgame", "\x04\bo:\tJamb\a:\v@cells[\x16[\to:\tCell\t:\n@type:\nLABEL:\v@valueI\"\x06X\x06:\x06EF:\r@enabledF:\f@is_colFo;\a\t;\b;\t;\nI\"\tDOWN\x06;\vF;\fF;\rFo;\a\t;\b;\t;\nI\"\aUP\x06;\vF;\fF;\rFo;\a\t;\b;\t;\nI\"\tFREE\x06;\vF;\fF;\rF[\to;\a\t;\b;\t;\nI\"\x061\x06;\vF;\fF;\rFo;\a\t;\b:\vNORMAL;\ni\b;\fF;\rFo;\a\t;\b;\x0E;\n0;\fF;\rFo;\a\t;\b;\x0E;\n0;\fT;\rF[\to;\a\t;\b;\t;\nI\"\x062\x06;\vF;\fF;\rFo;\a\t;\b;\x0E;\n0;\fT;\rFo;\a\t;\b;\x0E;\n0;\fF;\rFo;\a\t;\b;\x0E;\n0;\fT;\rF[\to;\a\t;\b;\t;\nI\"\x063\x06;\vF;\fF;\rFo;\a\t;\b;\x0E;\n0;\fF;\rFo;\a\t;\b;\x0E;\n0;\fF;\rFo;\a\t;\b;\x0E;\n0;\fT;\rF[\to;\a\t;\b;\t;\nI\"\x064\x06;\vF;\fF;\rFo;\a\t;\b;\x0E;\n0;\fF;\rFo;\a\t;\b;\x0E;\n0;\fF;\rFo;\a\t;\b;\x0E;\n0;\fT;\rF[\to;\a\t;\b;\t;\nI\"\x065\x06;\vF;\fF;\rFo;\a\t;\b;\x0E;\n0;\fF;\rFo;\a\t;\b;\x0E;\n0;\fF;\rFo;\a\t;\b;\x0E;\n0;\fT;\rF[\to;\a\t;\b;\t;\nI\"\x066\x06;\vF;\fF;\rFo;\a\t;\b;\x0E;\n0;\fF;\rFo;\a\t;\b;\x0E;\n0;\fF;\rFo;\a\t;\b;\x0E;\n0;\fT;\rF[\to;\a\t;\b;\t;\nI\"\bBon\x06;\vF;\fF;\rTo;\a\t;\b:\tCALC;\n0;\fF;\rFo;\a\t;\b;\x0F;\n0;\fF;\rFo;\a\t;\b;\x0F;\n0;\fF;\rF[\to;\a\t;\b;\t;\nI\"\bSUM\x06;\vF;\fF;\rTo;\a\t;\b;\x0F;\n0;\fF;\rFo;\a\t;\b;\x0F;\n0;\fF;\rFo;\a\t;\b;\x0F;\n0;\fF;\rF[\to;\a\t;\b;\t;\nI\"\aMx\x06;\vF;\fF;\rFo;\a\t;\b;\x0E;\n0;\fF;\rFo;\a\t;\b;\x0E;\n0;\fF;\rFo;\a\t;\b;\x0E;\n0;\fT;\rF[\to;\a\t;\b;\t;\nI\"\aMn\x06;\vF;\fF;\rFo;\a\t;\b;\x0E;\n0;\fF;\rFo;\a\t;\b;\x0E;\n0;\fF;\rFo;\a\t;\b;\x0E;\n0;\fT;\rF[\to;\a\t;\b;\t;\nI\"\bDIF\x06;\vF;\fF;\rTo;\a\t;\b;\x0F;\n0;\fF;\rFo;\a\t;\b;\x0F;\n0;\fF;\rFo;\a\t;\b;\x0F;\n0;\fF;\rF[\to;\a\t;\b;\t;\nI\"\x06K\x06;\vF;\fF;\rFo;\a\t;\b;\x0E;\n0;\fF;\rFo;\a\t;\b;\x0E;\n0;\fF;\rFo;\a\t;\b;\x0E;\n0;\fT;\rF[\to;\a\t;\b;\t;\nI\"\x06F\x06;\vF;\fF;\rFo;\a\t;\b;\x0E;\n0;\fF;\rFo;\a\t;\b;\x0E;\n0;\fF;\rFo;\a\t;\b;\x0E;\n0;\fT;\rF[\to;\a\t;\b;\t;\nI\"\x06P\x06;\vF;\fF;\rFo;\a\t;\b;\x0E;\n0;\fF;\rFo;\a\t;\b;\x0E;\n0;\fF;\rFo;\a\t;\b;\x0E;\n0;\fT;\rF[\to;\a\t;\b;\t;\nI\"\x06J\x06;\vF;\fF;\rFo;\a\t;\b;\x0E;\n0;\fF;\rFo;\a\t;\b;\x0E;\n0;\fT;\rFo;\a\t;\b;\x0E;\n0;\fT;\rF[\to;\a\t;\b;\t;\nI\"\bSUM\x06;\vF;\fF;\rTo;\a\t;\b;\x0F;\n0;\fF;\rFo;\a\t;\b;\x0F;\n0;\fF;\rFo;\a\t;\b;\x0F;\n0;\fF;\rF:\x0F@diceboardo:\x0EDiceBoard\a:\v@dices[\v000000:\x0E@selected[\vFFFFFF"], ["updated_at", Sat, 27 Jul 2013 17:35:44 UTC +00:00]]
   (101.0ms)  commit transaction
=> true
irb(main):011:0> g1 = Game.find(6)
  Game Load (0.5ms)  SELECT "games".* FROM "games" WHERE "games"."id" = ? LIMIT 1  [["id", 6]]
=> #<Game id: 6, jambgame: "\x04\bo:\tJamb\a:\v@cells[\x16[\to:\tCell\t:\n@type:\nLABEL:\v@valu...", user_id: nil, created_at: "2013-07-27 17:30:29", updated_at: "2013-07-27 17:35:44">
irb(main):012:0> j2 = g1.to_jamb
=> #<Jamb:0x00000004bdaf48 @cells=[[cell type LABEL  @value X @enabled false, cell type LABEL  @value DOWN @enabled false, cell type LABEL  @value UP @enabled false, cell type LABEL  @value FREE @enabled false], [cell type LABEL  @value 1 @enabled false, cell type NORMAL  @value 3 @enabled false, cell type NORMAL  @value  @enabled false, cell type NORMAL  @value  @enabled true], [cell type LABEL  @value 2 @enabled false, cell type NORMAL  @value  @enabled true, cell type NORMAL  @value  @enabled false, cell type NORMAL  @value  @enabled true], [cell type LABEL  @value 3 @enabled false, cell type NORMAL  @value  @enabled false, cell type NORMAL  @value  @enabled false, cell type NORMAL  @value  @enabled true], [cell type LABEL  @value 4 @enabled false, cell type NORMAL  @value  @enabled false, cell type NORMAL  @value  @enabled false, cell type NORMAL  @value  @enabled true], [cell type LABEL  @value 5 @enabled false, cell type NORMAL  @value  @enabled false, cell type NORMAL  @value  @enabled false, cell type NORMAL  @value  @enabled true], [cell type LABEL  @value 6 @enabled false, cell type NORMAL  @value  @enabled false, cell type NORMAL  @value  @enabled false, cell type NORMAL  @value  @enabled true], [cell type LABEL  @value Bon @enabled false, cell type CALC  @value  @enabled false, cell type CALC  @value  @enabled false, cell type CALC  @value  @enabled false], [cell type LABEL  @value SUM @enabled false, cell type CALC  @value  @enabled false, cell type CALC  @value  @enabled false, cell type CALC  @value  @enabled false], [cell type LABEL  @value Mx @enabled false, cell type NORMAL  @value  @enabled false, cell type NORMAL  @value  @enabled false, cell type NORMAL  @value  @enabled true], [cell type LABEL  @value Mn @enabled false, cell type NORMAL  @value  @enabled false, cell type NORMAL  @value  @enabled false, cell type NORMAL  @value  @enabled true], [cell type LABEL  @value DIF @enabled false, cell type CALC  @value  @enabled false, cell type CALC  @value  @enabled false, cell type CALC  @value  @enabled false], [cell type LABEL  @value K @enabled false, cell type NORMAL  @value  @enabled false, cell type NORMAL  @value  @enabled false, cell type NORMAL  @value  @enabled true], [cell type LABEL  @value F @enabled false, cell type NORMAL  @value  @enabled false, cell type NORMAL  @value  @enabled false, cell type NORMAL  @value  @enabled true], [cell type LABEL  @value P @enabled false, cell type NORMAL  @value  @enabled false, cell type NORMAL  @value  @enabled false, cell type NORMAL  @value  @enabled true], [cell type LABEL  @value J @enabled false, cell type NORMAL  @value  @enabled false, cell type NORMAL  @value  @enabled true, cell type NORMAL  @value  @enabled true], [cell type LABEL  @value SUM @enabled false, cell type CALC  @value  @enabled false, cell type CALC  @value  @enabled false, cell type CALC  @value  @enabled false]], @diceboard=#<DiceBoard:0x00000004be5f10 @dices=[nil, nil, nil, nil, nil, nil], @selected=[false, false, false, false, false, false]>>
irb(main):013:0> g.cell(1,1).value
NoMethodError: undefined method `cell' for #<Game:0x00000003409310>
	from /usr/lib/ruby/gems/1.9.1/gems/activemodel-4.0.0/lib/active_model/attribute_methods.rb:436:in `method_missing'
	from /usr/lib/ruby/gems/1.9.1/gems/activerecord-4.0.0/lib/active_record/attribute_methods.rb:131:in `method_missing'
	from (irb):13
	from /usr/lib/ruby/gems/1.9.1/gems/railties-4.0.0/lib/rails/commands/console.rb:90:in `start'
	from /usr/lib/ruby/gems/1.9.1/gems/railties-4.0.0/lib/rails/commands/console.rb:9:in `start'
	from /usr/lib/ruby/gems/1.9.1/gems/railties-4.0.0/lib/rails/commands.rb:64:in `<top (required)>'
	from bin/rails:4:in `require'
	from bin/rails:4:in `<main>'
irb(main):014:0> j2.cell(1,1).value
=> 3
irb(main):015:0> j2.cell(1,1).is_enabled?
=> false
irb(main):016:0> (0..2).size
NoMethodError: undefined method `size' for 0..2:Range
	from (irb):16
	from /usr/lib/ruby/gems/1.9.1/gems/railties-4.0.0/lib/rails/commands/console.rb:90:in `start'
	from /usr/lib/ruby/gems/1.9.1/gems/railties-4.0.0/lib/rails/commands/console.rb:9:in `start'
	from /usr/lib/ruby/gems/1.9.1/gems/railties-4.0.0/lib/rails/commands.rb:64:in `<top (required)>'
	from bin/rails:4:in `require'
	from bin/rails:4:in `<main>'
irb(main):017:0> reload!
Reloading...
=> true
irb(main):018:0> j = Jamb.new
=> #<Jamb:0x00000004eaff48 @cells=[[cell type LABEL  @value X @enabled false, cell type LABEL  @value DOWN @enabled false, cell type LABEL  @value UP @enabled false, cell type LABEL  @value FREE @enabled false], [cell type LABEL  @value 1 @enabled false, cell type NORMAL  @value  @enabled true, cell type NORMAL  @value  @enabled false, cell type NORMAL  @value  @enabled true], [cell type LABEL  @value 2 @enabled false, cell type NORMAL  @value  @enabled false, cell type NORMAL  @value  @enabled false, cell type NORMAL  @value  @enabled true], [cell type LABEL  @value 3 @enabled false, cell type NORMAL  @value  @enabled false, cell type NORMAL  @value  @enabled false, cell type NORMAL  @value  @enabled true], [cell type LABEL  @value 4 @enabled false, cell type NORMAL  @value  @enabled false, cell type NORMAL  @value  @enabled false, cell type NORMAL  @value  @enabled true], [cell type LABEL  @value 5 @enabled false, cell type NORMAL  @value  @enabled false, cell type NORMAL  @value  @enabled false, cell type NORMAL  @value  @enabled true], [cell type LABEL  @value 6 @enabled false, cell type NORMAL  @value  @enabled false, cell type NORMAL  @value  @enabled false, cell type NORMAL  @value  @enabled true], [cell type LABEL  @value Bon @enabled false, cell type CALC  @value  @enabled false, cell type CALC  @value  @enabled false, cell type CALC  @value  @enabled false], [cell type LABEL  @value SUM @enabled false, cell type CALC  @value  @enabled false, cell type CALC  @value  @enabled false, cell type CALC  @value  @enabled false], [cell type LABEL  @value Mx @enabled false, cell type NORMAL  @value  @enabled false, cell type NORMAL  @value  @enabled false, cell type NORMAL  @value  @enabled true], [cell type LABEL  @value Mn @enabled false, cell type NORMAL  @value  @enabled false, cell type NORMAL  @value  @enabled false, cell type NORMAL  @value  @enabled true], [cell type LABEL  @value DIF @enabled false, cell type CALC  @value  @enabled false, cell type CALC  @value  @enabled false, cell type CALC  @value  @enabled false], [cell type LABEL  @value K @enabled false, cell type NORMAL  @value  @enabled false, cell type NORMAL  @value  @enabled false, cell type NORMAL  @value  @enabled true], [cell type LABEL  @value F @enabled false, cell type NORMAL  @value  @enabled false, cell type NORMAL  @value  @enabled false, cell type NORMAL  @value  @enabled true], [cell type LABEL  @value P @enabled false, cell type NORMAL  @value  @enabled false, cell type NORMAL  @value  @enabled false, cell type NORMAL  @value  @enabled true], [cell type LABEL  @value J @enabled false, cell type NORMAL  @value  @enabled false, cell type NORMAL  @value  @enabled true, cell type NORMAL  @value  @enabled true], [cell type LABEL  @value SUM @enabled false, cell type CALC  @value  @enabled false, cell type CALC  @value  @enabled false, cell type CALC  @value  @enabled false]], @diceboard=#<DiceBoard:0x00000004fad3f0 @num=5, @dices=[nil, nil, nil, nil, nil], @selected=[false, false, false, false, false], @mode=:no_roll>>
irb(main):019:0> j.enable_next(13,2)
ROw:13 col 2
ROw:13 col 2 - NEXT NORMAL  11 diff -2 
RuntimeError: RuntimeError
	from /home/braca/develop/rails/cjproject/app/models/cell.rb:18:in `enable'
	from /home/braca/develop/rails/cjproject/app/models/jamb.rb:105:in `enable_next'
	from (irb):19
	from /usr/lib/ruby/gems/1.9.1/gems/railties-4.0.0/lib/rails/commands/console.rb:90:in `start'
	from /usr/lib/ruby/gems/1.9.1/gems/railties-4.0.0/lib/rails/commands/console.rb:9:in `start'
	from /usr/lib/ruby/gems/1.9.1/gems/railties-4.0.0/lib/rails/commands.rb:64:in `<top (required)>'
	from bin/rails:4:in `require'
	from bin/rails:4:in `<main>'
irb(main):020:0> j.enable_next(12,2)
ROw:12 col 2
ROw:12 col 2 - NEXT NORMAL  11 diff -1 
RuntimeError: RuntimeError
	from /home/braca/develop/rails/cjproject/app/models/cell.rb:18:in `enable'
	from /home/braca/develop/rails/cjproject/app/models/jamb.rb:105:in `enable_next'
	from (irb):20
	from /usr/lib/ruby/gems/1.9.1/gems/railties-4.0.0/lib/rails/commands/console.rb:90:in `start'
	from /usr/lib/ruby/gems/1.9.1/gems/railties-4.0.0/lib/rails/commands/console.rb:9:in `start'
	from /usr/lib/ruby/gems/1.9.1/gems/railties-4.0.0/lib/rails/commands.rb:64:in `<top (required)>'
	from bin/rails:4:in `require'
	from bin/rails:4:in `<main>'
irb(main):021:0> g  = Game.find(28)
  Game Load (0.9ms)  SELECT "games".* FROM "games" WHERE "games"."id" = ? LIMIT 1  [["id", 28]]
=> #<Game id: 28, jambgame: "\x04\bo:\tJamb\a:\v@cells[\x16[\to:\tCell\t:\n@type:\nLABEL:\v@valu...", user_id: nil, created_at: "2013-07-28 03:16:40", updated_at: "2013-07-28 03:32:12">
irb(main):022:0> puts g.jambgame.size
1543
=> nil
irb(main):023:0> reload!
Reloading...
=> true
irb(main):024:0> j = Jamb.new
=> #<Jamb:0x00000004b5ed80 @cells=[[cell type LABEL  @value X @enabled false, cell type LABEL  @value DOWN @enabled false, cell type LABEL  @value UP @enabled false, cell type LABEL  @value FREE @enabled false], [cell type LABEL  @value 1 @enabled false, cell type NORMAL  @value  @enabled true, cell type NORMAL  @value  @enabled false, cell type NORMAL  @value  @enabled true], [cell type LABEL  @value 2 @enabled false, cell type NORMAL  @value  @enabled false, cell type NORMAL  @value  @enabled false, cell type NORMAL  @value  @enabled true], [cell type LABEL  @value 3 @enabled false, cell type NORMAL  @value  @enabled false, cell type NORMAL  @value  @enabled false, cell type NORMAL  @value  @enabled true], [cell type LABEL  @value 4 @enabled false, cell type NORMAL  @value  @enabled false, cell type NORMAL  @value  @enabled false, cell type NORMAL  @value  @enabled true], [cell type LABEL  @value 5 @enabled false, cell type NORMAL  @value  @enabled false, cell type NORMAL  @value  @enabled false, cell type NORMAL  @value  @enabled true], [cell type LABEL  @value 6 @enabled false, cell type NORMAL  @value  @enabled false, cell type NORMAL  @value  @enabled false, cell type NORMAL  @value  @enabled true], [cell type LABEL  @value Bon @enabled false, cell type CALC  @value  @enabled false, cell type CALC  @value  @enabled false, cell type CALC  @value  @enabled false], [cell type LABEL  @value SUM @enabled false, cell type CALC  @value  @enabled false, cell type CALC  @value  @enabled false, cell type CALC  @value  @enabled false], [cell type LABEL  @value Mx @enabled false, cell type NORMAL  @value  @enabled false, cell type NORMAL  @value  @enabled false, cell type NORMAL  @value  @enabled true], [cell type LABEL  @value Mn @enabled false, cell type NORMAL  @value  @enabled false, cell type NORMAL  @value  @enabled false, cell type NORMAL  @value  @enabled true], [cell type LABEL  @value DIF @enabled false, cell type CALC  @value  @enabled false, cell type CALC  @value  @enabled false, cell type CALC  @value  @enabled false], [cell type LABEL  @value K @enabled false, cell type NORMAL  @value  @enabled false, cell type NORMAL  @value  @enabled false, cell type NORMAL  @value  @enabled true], [cell type LABEL  @value F @enabled false, cell type NORMAL  @value  @enabled false, cell type NORMAL  @value  @enabled false, cell type NORMAL  @value  @enabled true], [cell type LABEL  @value P @enabled false, cell type NORMAL  @value  @enabled false, cell type NORMAL  @value  @enabled false, cell type NORMAL  @value  @enabled true], [cell type LABEL  @value J @enabled false, cell type NORMAL  @value  @enabled false, cell type NORMAL  @value  @enabled true, cell type NORMAL  @value  @enabled true], [cell type LABEL  @value SUM @enabled false, cell type CALC  @value  @enabled false, cell type CALC  @value  @enabled false, cell type CALC  @value  @enabled false]], @diceboard=#<DiceBoard:0x00000004a56a78 @num=5, @dices=[nil, nil, nil, nil, nil], @selected=[false, false, false, false, false], @mode=:no_roll>, @empty=36, @playround=0>
irb(main):025:0> j.to_game_string
LocalJumpError: no block given (yield)
	from /home/braca/develop/rails/cjproject/app/models/jamb.rb:65:in `block in rows'
	from /home/braca/develop/rails/cjproject/app/models/jamb.rb:64:in `each'
	from /home/braca/develop/rails/cjproject/app/models/jamb.rb:64:in `rows'
	from /home/braca/develop/rails/cjproject/app/models/jamb.rb:241:in `to_game_string'
	from (irb):25
	from /usr/lib/ruby/gems/1.9.1/gems/railties-4.0.0/lib/rails/commands/console.rb:90:in `start'
	from /usr/lib/ruby/gems/1.9.1/gems/railties-4.0.0/lib/rails/commands/console.rb:9:in `start'
	from /usr/lib/ruby/gems/1.9.1/gems/railties-4.0.0/lib/rails/commands.rb:64:in `<top (required)>'
	from bin/rails:4:in `require'
	from bin/rails:4:in `<main>'
irb(main):026:0> 