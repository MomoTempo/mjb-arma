
class ACE_Medical_Injuries {
    class damageTypes {
        class woundHandlers;
        class bullet {
            class Contusion {
                weighting[] = {{0.35, 0}, {0.35, 1},{0.05,1},{0.05,0}};
			};
        };
        class grenade {
			thresholds[] = {{20, 3}, {10, 2}, {4, 2}, {1.5, 2}, {0.8, 1}, {0.3, 1}, {0.05, 1}, {0.05, 0}, {0, 0}};
        };
        class explosive {
            thresholds[] = {{20, 3}, {8, 3}, {2, 2}, {1.2, 1}, {0.4, 1}, {0.05, 1}, {0.05, 0}, {0,0}};
        };
        class shell {
            thresholds[] = {{20, 3}, {10, 2}, {4.5, 2}, {2, 2}, {0.8, 1}, {0.2, 1}, {0.05, 1}, {0.05, 0}, {0, 0}};
        };
        class vehiclecrash {
            thresholds[] = {{1.5, 3}, {1.5, 2}, {1, 2}, {1, 1}, {0.05, 1}, {0.05, 0}, {0, 0}};
        };
        class collision {
            thresholds[] = {{8, 3}, {1, 1}, {0.3, 1}, {0.15, 0.5}, {0.05, 0.3}, {0.05, 0}, {0, 0}};
		};
        class falling {
            thresholds[] = {{8, 3}, {1, 1}, {0.2, 1}, {0.1, 0.7}, {0.05, 0.5}, {0.05, 0}, {0, 0}};
		};
        class stab {
        };
        class punch {
        };
        class burn {
            thresholds[] = {{1.0, 0.5},{0, 0.3}};
            class ThermalBurn {
                sizeMultiplier = 0.5;
            };
		};
        class unknown {
        };
    };
};
