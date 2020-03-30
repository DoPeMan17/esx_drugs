USE `essentialmode`;

INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES
	('cannabis', 'Cannabis', 3, 0, 1),
	('marijuana', 'Marijuana', 2, 0, 1),
	('chemicals', 'Chemicals', 0.5, 0, 1),
	('chemicalslisence', 'Chemicals license', 0, 0, 1),
	('moneywash', 'MoneyWash License', 0, 0, 1),
	('coca_leaf', 'Coca Leaf', 3, 0, 1),
	('coke', 'Coke', 3, 0, 1),
	('poppyresin', 'Poppy Resin', 0.5, 0, 1),
	('heroin', 'Heroin', 2, 0, 1),
	('lsa', 'LSA', 1, 0, 1),
	('lsd', 'LSD', 1, 0, 1),
	('meth', 'Meth', 3, 0, 1),
	('hydrochloric_acid', 'HydroChloric Acid', 2, 0, 1),
	('sodium_hydroxide', 'Sodium Hydroxide', 2, 0, 1),
	('sulfuric_acid', 'Sulfuric Acid', 2, 0, 1),
	('thionyl_chloride', 'Thionyl Chloride', 0.5, 0, 1)
;

INSERT INTO `licenses` (`type`, `label`) VALUES
	('weed_processing', 'Weed Processing License')
;