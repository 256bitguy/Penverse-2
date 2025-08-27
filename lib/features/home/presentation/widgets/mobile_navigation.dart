import 'package:flutter/material.dart';

class MobileNavigation extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onDestinationSelected;

  const MobileNavigation({
    super.key,
    required this.selectedIndex,
    required this.onDestinationSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: const Color(0xFF1B1E23),
        border: Border(
          top: BorderSide(
            color: Colors.white.withOpacity(0.1),
            width: 1,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _NavItem(
            icon: Icons.home_outlined,
            selectedIcon: Icons.home,
            label: 'Vocab',
            isSelected: selectedIndex == 0,
            onTap: () => onDestinationSelected(0),
          ),
          _NavItem(
            icon: Icons.dynamic_feed_outlined,
            selectedIcon: Icons.dynamic_feed,
            label: 'grammer',
            isSelected: selectedIndex == 1,
            onTap: () => onDestinationSelected(1),
          ),
          _CreateButton(
            onTap: () => onDestinationSelected(2),
            isSelected: selectedIndex == 2,
          ),
          _NavItem(
            icon: Icons.event_outlined,
            selectedIcon: Icons.event,
            label: 'misc.',
            isSelected: selectedIndex == 3,
            onTap: () => onDestinationSelected(3),
          ),
          _NavItem(
            icon: Icons.people_outline,
            selectedIcon: Icons.people,
            label: 'phrasal',
            isSelected: selectedIndex == 4,
            onTap: () => onDestinationSelected(4),
          ),
        ],
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final IconData selectedIcon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.selectedIcon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isSelected ? selectedIcon : icon,
            color: isSelected ? Theme.of(context).primaryColor : Colors.white70,
            size: 24,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: isSelected ? Theme.of(context).primaryColor : Colors.white70,
              fontSize: 12,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}

class _CreateButton extends StatelessWidget {
  final VoidCallback onTap;
  final bool isSelected;

  const _CreateButton({
    required this.onTap,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Theme.of(context).primaryColor,
        ),
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 32,
        ),
      ),
    );
  }
}