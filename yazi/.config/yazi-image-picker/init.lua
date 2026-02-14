local old_layout = Tab.layout
Status.redraw = function()
	return {}
end
Header.redraw = function()
	return {}
end
Tab.layout = function(self, ...)
	self._area = ui.Rect({ x = self._area.x, y = self._area.y - 1, w = self._area.w, h = self._area.h + 2 })
	return old_layout(self, ...)
end
