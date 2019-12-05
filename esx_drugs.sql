USE `essentialmode`;

INSERT INTO `items` (`name`, `label`, `rare`, `can_remove`) VALUES
	('cannabis', 'Cannabis', 40, 0, 1),
	('marijuana', 'Marijuana', 14, 0, 1),
	('chemicals', 'Chemicals', 100, 0, 1),
	('chemicalslisence', 'Chemicals license', 1, 0, 1),
	('moneywash', 'MoneyWash License', 1, 0, 1),
	('coca_leaf', 'Coca Leaf', 40, 0, 1),
	('coke', 'Coke', 40, 0, 1),
	('poppyresin', 'Poppy Resin', 160, 0, 1),
	('heroin', 'Heroin', 80, 0, 1),
	('lsa', 'LSA', 100, 0, 1),
	('lsd', 'LSD', 100, 0, 1),
	('meth', 'Meth', 30, 0, 1),
	('hydrochloric_acid', 'HydroChloric Acid', 15, 0, 1),
	('sodium_hydroxide', 'Sodium Hydroxide', 15, 0, 1),
	('sulfuric_acid', 'Sulfuric Acid', 15, 0, 1),
	('thionyl_chloride', 'Thionyl Chloride', 100, 0, 1)
;

INSERT INTO `licenses` (`type`, `label`) VALUES
	('weed_processing', 'Weed Processing License')
	('chemicalslisence', 'Chemicals license')
;
