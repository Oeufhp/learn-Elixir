defmodule Identicon do
	def main(input) do
		input 
		|> hash_input 
		|> pick_color 
		|> build_grid
		|> filter_odd_squares
		|> build_pixel_map
		|> draw_image
		|> save_image(input)
	end

	def hash_input(input) do
		hex = :crypto.hash(:md5, input) 
		|> :binary.bin_to_list

		%Identicon.Image{hex: hex}
	end

	def pick_color(%Identicon.Image{hex: [r, g, b | _tail]} = image) do # pattern matching
		%Identicon.Image{image | color: {r, g, b}} # update map
	end

	def build_grid(%Identicon.Image{hex: hex} = image) do
		grid = hex 
		|> Enum.chunk(3) # make list of lists by the given number
		|> Enum.map(&mirror_row/1) # map function of each row
		|> List.flatten
		|> Enum.with_index

		%Identicon.Image{image| grid: grid}
	end

	def mirror_row(row) do
		[first, second| _tail] = row
		row ++ [second, first]
	end

	def filter_odd_squares(%Identicon.Image{grid: grid} = image) do
		new_grid = Enum.filter grid, fn({code, _index}) -> 
			rem(code, 2) == 0
		end

		%Identicon.Image{image| grid: new_grid}
	end

	def build_pixel_map(%Identicon.Image{grid: grid} = image) do
		pixel_map = Enum.map grid, fn({_code, index}) ->  #Function for find top_left and bottom_right of each pixel
			horizontal = rem(index, 5) * 50 # remainder function
			vertical = div(index, 5) * 50 # divide function
			top_left = {horizontal, vertical}
			bottom_right = {horizontal + 50, vertical + 50}
			{top_left, bottom_right}
		end
		%Identicon.Image{image | pixel_map: pixel_map} 
	end

	def draw_image(%Identicon.Image{color: color, pixel_map: pixel_map} = image) do
		image = :egd.create(250, 250)
		fill = :egd.color(color)

		Enum.each pixel_map, fn({start, stop}) -> 
				:egd.filledRectangle(image, start, stop, fill)
		end

			:egd.render(image)
	end
	
	def save_image(image, input) do
		File.write("#{input}.png", image)
	end
end
