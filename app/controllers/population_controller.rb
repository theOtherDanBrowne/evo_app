class PopulationController < ApplicationController

	before_filter :get_creatures, :only=> [:index, :kill, :kill_random, :clone_random, :mutate_gnome]

 def get_creatures
 		total_population = 100
    
  	#@population = Creature.order("id desc").limit(total_population).reverse
  	@population = Creature.find(:all, :conditions => {:generation => Creature.maximum(:generation) })
  	@population.each do |creature|
  		creature.get_colors
  	end
 end
 
 def index
    
  	  	
  		
 end
  
  def start
  	Creature.destroy_all
   	total_population = 100
  	@population = [];
  	while @population.length < total_population do
  		creature = Creature.new
  		creature.generation = 1
  		creature.mutation = -1
  		creature.randomize_gnome
 			
  		creature.save
  	
  		@population << creature
  	end
  	redirect_to(root_path)
  end

	def kill
		
		@killed = []	
		#sort by luminosity/brightness
		@population_kill = @population.clone
		@population_kill.sort! { |a, b|
  		a.color_rgb.to_hsl.l <=> b.color_rgb.to_hsl.l
  	}
		to_kill = params[:total].to_i - 1
		@population_kill[0..to_kill].each do |creature|
			@killed << creature.id
			creature.destroy
		end
		#redirect_to(root_path)
	
	end
	
	def kill_random
	
		@killed = []	
		#sort by random
		@population_kill = @population.clone
		@population_kill = @population.sort_by{ rand }
		
		to_kill = params[:total].to_i - 1
		@population_kill	[0..to_kill].each do |creature|
			creature.destroy
			@killed << creature.id
		end
		render :action => 'kill'
		#redirect_to(root_path)
	end
	
	def clone_random
		
		#sort by random
		#@population = @population.sort_by{ rand }
		
		total_population = 100
		
		@new_population = []
		while @new_population.length < total_population do
			chance = rand(0..@population.length)
			creature = @population[rand(0..(@population.length-1))]
			new_creature = Creature.new(creature.attributes)
			new_creature.generation = creature.generation + 1
  		new_creature.mutation = -1
 			
  		new_creature.save
  	
  		@new_population << new_creature
			
		end
	redirect_to(root_path)
	
	end
	
	def mutate_gnome
		
		
		mutations = 0
		while mutations < 5 do 
		creature = @population[rand(0..99)]
		chance =  rand(0..23)
		new_gnome = creature.gnome.clone
		new_gnome[chance] = self.change_bit(new_gnome[chance])
		creature.gnome = new_gnome
		
		creature.mutation =  chance
		creature.r_gnome = creature.gnome.slice(0..7)
		creature.g_gnome = creature.gnome.slice(8..15)
		creature.b_gnome = creature.gnome.slice(16..23)
		
		creature.get_colors
		creature.save
		mutations = mutations +1
		end
		redirect_to(root_path)
	end
	
	def change_bit(b)
	
	if b == "1"
		return "0"
	elsif b == "0"
		return "1"
	end
	
	end


	
end
